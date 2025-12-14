extends Resource
class_name ItemData  # <--- GANZ WICHTIG!

@export var name: String = ""
@export var icon: Texture2D
@export var model: PackedScene
@export var collision_shape: Shape3D

@export_group("Hand Placement")
@export var rotation_offset: Vector3 = Vector3.ZERO
@export var position_offset: Vector3 = Vector3.ZERO
