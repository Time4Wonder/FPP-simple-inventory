extends SubViewport

func _ready():
	# WICHTIG: Wir zwingen den Viewport, die Haupt-Welt zu nutzen!
	world_3d = get_tree().root.get_viewport().world_3d
