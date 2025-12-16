## The HUD for the Inventory. 

extends CanvasLayer

## A ref needed of the inventory (logic) node in the player character 
@export var inventory: Node
@onready var h_box_container: HBoxContainer = $Control/HBoxContainer

func _ready() -> void:
	if inventory:
		inventory.inventory_updated.connect(update_ui)
		update_ui()
	else: 
		print("WARNING: UI is not connected to the Inventory.")
		
func update_ui():
	var slots = h_box_container.get_children()
	
	for i in range(slots.size()):
		# render icons	
		var icon: TextureRect = slots[i].get_child(0)
		if inventory.items[i] != null:
			icon.texture = inventory.items[i].icon
		else:
			icon.texture = null	
			
		#render currentslot correctly
		var stylebox = slots[i].get_theme_stylebox("panel")
		if i == inventory.current_slot_index:
			stylebox.border_width_left = 4
			stylebox.border_width_right = 4
			stylebox.border_width_top = 4
			stylebox.border_width_bottom = 4
		else:
			stylebox.border_width_left = 0
			stylebox.border_width_right = 0
			stylebox.border_width_top = 0
			stylebox.border_width_bottom = 0
