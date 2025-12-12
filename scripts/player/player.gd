extends CharacterBody3D


var speed = 0.0
var crouch_speed = 10
const CROUCH_HEIGHT = 0.9
const DEFAULT_HEIGHT = 2.0
const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const CROUCH_SPEED = 3.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY = 0.01


#bob variables
const BOB_FREQ = 3.0
const BOB_AMP = 0.05
var bob_time = 0.0

#fov variables:
const BASE_FOV = 75.0
const FOV_CHANGE = 1.5

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var collision_shape = $CollisionShape3D
@onready var head_bonker = $HeadBonker

@export var fov_change_on_velocity = true

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Handle sprint
	handle_sprint()
	handle_crouch(delta)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		# ground friction
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7)	
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7)
	# air control / air movement control
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 4)	
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 4)
		
	# head bob
	handle_headbob(delta)
		
	handle_fov_change(delta)
		
	move_and_slide()

func handle_sprint():
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED
		
func handle_crouch(delta):
	if Input.is_action_pressed("crouch"):
		speed = CROUCH_SPEED
		collision_shape.shape.height -= crouch_speed * delta
	elif not head_bonker.is_colliding(): 
		collision_shape.shape.height += crouch_speed * delta
	collision_shape.shape.height = clamp(collision_shape.shape.height, CROUCH_HEIGHT, DEFAULT_HEIGHT)
	
func handle_fov_change(delta):
	if fov_change_on_velocity:
		var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
		var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, 7 * delta)

func handle_headbob(delta):
	if velocity:
		bob_time += delta * velocity.length() * float(is_on_floor())
		camera.position = _headbob(bob_time)
	else:
		camera.position = lerp(camera.position, Vector3.ZERO, delta * 8)
		bob_time = 0

func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
