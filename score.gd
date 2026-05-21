extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var view_port = get_viewport()
	global_position = Vector2i(50, 50)-view_port.size/2
