extends Camera3D

@export var main_camera: Camera3D

func _process(delta: float) -> void:
	if main_camera:
		global_transform = main_camera.global_transform
