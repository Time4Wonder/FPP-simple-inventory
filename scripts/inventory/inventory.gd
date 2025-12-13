extends Node

@export var max_slots: int = 4
var items: Array[ItemData] = []
var current_slot_index = 0

signal inventory_updated # Signal to the UI

func _ready() -> void:
	items.resize(max_slots)
	print(items[0])
	print(items)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drop_item"):
		drop_item_current_item()
		
	if event.is_action_pressed("hotbar_next"):
		if current_slot_index >= items.size() - 1:
			current_slot_index = 0
		else:
			current_slot_index += 1
	inventory_updated.emit()
	
		
	if event.is_action_pressed("hotbar_previous"):
		if current_slot_index <= 0:
			current_slot_index = items.size() - 1 
		else:
			current_slot_index -= 1
		inventory_updated.emit()


func add_item(item: ItemData):
	for i in range(items.size()): 
		if items[i] == null:
			items[i] = item
			inventory_updated.emit()
			break
	print(items)
	
func drop_item_current_item():
	if items[current_slot_index] != null:
		items[current_slot_index] = null
		inventory_updated.emit()
		
		print(items)
	
func switchItem():
	current_slot_index += 1
	inventory_updated.emit()
	print(items)
	
func is_full() -> bool:
	for i in items:
		if i == null:
			return false
	return true
