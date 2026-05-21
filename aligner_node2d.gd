extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var viewport = get_viewport()
	global_position = Vector2(viewport.size.x/2, viewport.size.y/2)
	
