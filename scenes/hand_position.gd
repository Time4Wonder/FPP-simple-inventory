extends Marker3D

@onready var inventory: Node = $"../../../Inventory"

func _ready() -> void:
	inventory.current_item_changed.connect(update_hand_model)
	

func update_hand_model(item: ItemData):
	for i in get_children():
		i.queue_free()
	
	if item != null:
		var new_model = item.model.instantiate()
		add_child(new_model)
		new_model.rotation += item.rotation_offset
		new_model.position += item.position_offset
