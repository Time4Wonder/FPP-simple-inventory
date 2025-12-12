extends RigidBody3D
class_name ItemPickup

@export var item_data: ItemData

func _ready():
	if item_data != null:
		setup_item()
		
func setup_item():
	if item_data.model:
		var model = item_data.model.instantiate()
		add_child(model)
		
func pick_up():
	queue_free()
	return item_data
