extends CharacterBody3D

@onready var armature: Node3D = $Armature
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationTree = $AnimationTree


var player: CharacterBody3D
var target_position: Vector3
var direction
var has_player_as_target = false
var speed = 200

const LERP_VALUE = 5


func _ready() -> void:
	target_position = position


func _physics_process(delta: float) -> void:

	#apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#alfred to target
	if position.distance_to(target_position) > 1:
		direction = Vector3(target_position.x - position.x, 0, target_position.z - position.z).normalized()
	else:
		direction = Vector3.ZERO
	velocity.x = direction.x * speed * delta 
	velocity.z = direction.z * speed * delta 
	
	#player follow
	if has_player_as_target:
		target_position = player.position
	
	# animations
	handle_animations(delta)
	#handle armature direction
	handle_rotation_to_direction(delta)
	move_and_slide()


func handle_animations(delta):
	if velocity:
		animation_tree["parameters/Blend2/blend_amount"] = lerp(animation_tree.get("parameters/Blend2/blend_amount"), 1.0, LERP_VALUE * delta)	
	else:
		animation_tree["parameters/Blend2/blend_amount"] = lerp(animation_tree.get("parameters/Blend2/blend_amount"), 0.0, LERP_VALUE * delta)

	
func handle_rotation_to_direction(delta):
	if direction:
		rotation.y = lerp(rotation.y,atan2(velocity.x, velocity.z), LERP_VALUE * delta)

func _on_view_field_body_entered(body: Node3D) -> void:
	if body == %Player:
		player = body
		has_player_as_target = true

func _on_view_field_body_exited(_body: Node3D) -> void:
	has_player_as_target = false
