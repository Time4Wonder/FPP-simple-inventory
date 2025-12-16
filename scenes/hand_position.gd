extends Marker3D

@onready var inventory: Node = $"../../../../../../Inventory"

var current_hand_item: HandItem

func _ready() -> void:
	inventory.current_item_changed.connect(update_hand_model)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_item"):
		if current_hand_item != null:
			current_hand_item.on_use()

func update_hand_model(item: ItemData):
	for i in get_children():
		i.queue_free()
	
	if item != null:
		var new_model = item.model.instantiate()
		add_child(new_model)
		_set_layer_recursive(new_model, 2)
		
		new_model.rotation += item.rotation_offset
		new_model.position += item.position_offset
		
		for i in get_children():
			if i is HandItem:
				current_hand_item = i
			else: 
				current_hand_item = null

func _set_layer_recursive(node, layer_index):
	if node is Light3D:
		node.set_layer_mask_value(1, true)
		node.set_layer_mask_value(layer_index, false)
	elif node is VisualInstance3D:
		# Mach Layer 1 (Welt) aus
		node.set_layer_mask_value(1, false)
		# Mach Layer 2 (Waffe) an
		node.set_layer_mask_value(layer_index, true)
	for child in node.get_children():
		_set_layer_recursive(child, layer_index)
