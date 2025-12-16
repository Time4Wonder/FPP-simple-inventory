extends HandItem

@onready var spot_light_3d: SpotLight3D = $SpotLight3D

func on_use():
	spot_light_3d.visible = !spot_light_3d.visible
