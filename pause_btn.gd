extends Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var view_port = get_viewport()
	global_position = Vector2(view_port.size.x - size.x - 100, 50)
