extends Marker3D

@onready var inventory: Node = $"../../../Inventory"

var current_hand_item: HandItem

func _ready() -> void:
	inventory.current_item_changed.connect(update_hand_model)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("use_item"):
		if current_hand_item != null:
			current_hand_item.on_use()

func update_hand_model(item: ItemData):
	for i in get_children():
		i.queue_free()
	
	if item != null:
		var new_model = item.model.instantiate()
		add_child(new_model)
		new_model.rotation += item.rotation_offset
		new_model.position += item.position_offset
		
		if get_child(0) is HandItem:
			current_hand_item = get_child(0)
		else: 
			current_hand_item = null
