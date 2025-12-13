extends Node

const ITEM_PICKUP = preload("uid://cnt808fskfi32")

@export var max_slots: int = 4
var items: Array[ItemData] = []
var current_slot_index = 0

signal inventory_updated # Signal to the UI

func _ready() -> void:
	items.resize(max_slots)

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
		
	if event.is_action_pressed("hotbar_1"):
		current_slot_index = 0
		inventory_updated.emit()
	if event.is_action_pressed("hotbar_2"):
		current_slot_index = 1
		inventory_updated.emit()
	if event.is_action_pressed("hotbar_3"):
		current_slot_index = 2
		inventory_updated.emit()
	if event.is_action_pressed("hotbar_4"):
		current_slot_index = 3
		inventory_updated.emit()


func add_item(item: ItemData):
	if items[current_slot_index] == null:
		items[current_slot_index] = item
	else:
		for i in range(items.size()): 
			if items[i] == null:
				items[i] = item
				inventory_updated.emit()
				break
	
func drop_item_current_item():
	if items[current_slot_index] != null:

		
		
		var drop: RigidBody3D = ITEM_PICKUP.instantiate()
		drop.item_data = items[current_slot_index]
		
		# adds the drop on the current treescene
		get_tree().current_scene.add_child(drop)
		#setting position
		var camera = get_viewport().get_camera_3d()
		var drop_position = camera.global_position + (camera.global_transform.basis.z * -1.5)
		drop.global_position = drop_position
		# Adding physics 
		var throw_direciton =  -camera.global_transform.basis.z
		var force = 5.0
		drop.apply_impulse(throw_direciton * force + Vector3(0,2,0))
		
		items[current_slot_index] = null
		inventory_updated.emit()
	
func switchItem():
	current_slot_index += 1
	inventory_updated.emit()
	
func is_full() -> bool:
	for i in items:
		if i == null:
			return false
	return true
