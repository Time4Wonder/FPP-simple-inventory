extends RayCast3D

@onready var inventory: Node = $"../../../Inventory"


func _physics_process(_delta: float) -> void:
	if is_colliding():
		var detected_object = get_collider()
		
		if detected_object is ItemPickup:
			if Input.is_action_just_pressed("Interact"):
				try_to_pick_up_item(detected_object)
				


func try_to_pick_up_item(item: ItemPickup):
	if !inventory.is_full():
		var item_data = item.pick_up()
		inventory.add_item(item_data)
	
