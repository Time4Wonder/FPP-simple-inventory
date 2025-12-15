extends RigidBody3D
class_name ItemPickup

@export var item_data: ItemData
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D

func _ready():
	if item_data != null:
		setup_item()
		
func setup_item():
	if item_data.model:
		var model = item_data.model.instantiate()
		add_child(model)
		collision_shape_3d.shape = item_data.collision_shape
		mass = item_data.mass
		
func pick_up():
	queue_free()
	return item_data
