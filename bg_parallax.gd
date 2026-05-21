extends Parallax2D

@export var gameManager: Node
	
func _process(delta):
	var viewport := get_viewport()
	repeat_size.x = viewport.size.x
	if gameManager.game_running:
		scroll_offset.x += gameManager.game_speed * delta
	 
