extends CanvasLayer

# A ref needed of the inventory (logic) node in the player character 
@export var inventory: Node
@onready var h_box_container: HBoxContainer = $Control/HBoxContainer

func _ready() -> void:
	if inventory:
		inventory.inventory_updated.connect(update_ui)
		update_ui()
	else: 
		print("WARNING: UI is not connected to the Inventory.")
func update_ui():
	pass
