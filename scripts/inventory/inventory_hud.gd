extends CanvasLayer

@onready var inventory: Node = $"../../Inventory"

func _ready() -> void:
	if inventory:
		inventory.inventory_updated.connect(update_ui)
		update_ui()
	else: 
		print("achtung ui hat keine verbindung zum inventar")
func update_ui():
	pass
