extends Node

@export var max_slots: int = 4
var items: Array[ItemData] = []
var current_slot_index = 0

signal inventory_updated # Signal to the UI


func _ready() -> void:
	items.resize(max_slots)
	print(items[0])
	print(items)
	
	
func add_item(item: ItemData):
	for i in range(items.size()): 
		if items[i] == null:
			items[i] == item
			inventory_updated.emit(item)
			break
	print(items)
	
func drop_item_current_item():
	items.remove_at(current_slot_index)
	inventory_updated.emit()
	print(items)
	
	

func switchItem():
	current_slot_index += 1
	inventory_updated.emit()
	print(items)
	
