extends StaticBody2D

@export var hitbox: CollisionShape2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var view_port = get_viewport()
	global_position.y = view_port.size.y - hitbox.shape.size.y*hitbox.scale.y
	
	hitbox.shape.size.x = view_port.size.x
