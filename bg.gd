extends Sprite2D

var last_size: Vector2

func _ready():
	_fit_to_screen()
	last_size = get_viewport_rect().size

func _process(_delta):
	var current_size = get_viewport_rect().size

	if current_size != last_size:
		_fit_to_screen()
		last_size = current_size


func _fit_to_screen():
	if texture == null:
		return

	var screen_size = get_viewport_rect().size
	var texture_size = texture.get_size()

	var scale_factor = screen_size / texture_size
	var final_scale = max(scale_factor.x, scale_factor.y)

	scale = Vector2(final_scale, final_scale)

	position = Vector2.ZERO
