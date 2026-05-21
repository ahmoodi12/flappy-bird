extends Node2D

@export var low_pipe: StaticBody2D
@export var high_pipe: StaticBody2D

@export var gameManager: Node  

var offset: int
var gap: int

var fading := false
var scored := false

var width: float
	
func fade(dur := 2.0):
	if fading: return
	fading = true
	
	for pipe in get_children():
		var sprite = pipe.get_node("Sprite2D")
		var tween = sprite.create_tween()
		tween.tween_property(sprite, "modulate:a", 0.0, dur)
	
	
func adjust_to_gap(pipe, gap_size, offset, is_top: bool):
	var screen_size = get_viewport().size
	var screen_center_y = screen_size.y / 2.0
	var gap_center_y = screen_center_y + offset
	var half_gap = gap_size / 2.0
	
	# true if gap doesn't allow space for the poles. (100 px rn)
	#if (gap_center_y + half_gap > screen_size.y - 50 or gap_center_y - half_gap < 50):
	#	pass

	# get pipe height (adjust node path if needed)
	var pipe_height = pipe.get_node("CollisionShape2D").shape.get_rect().size.y
	var half_pipe = pipe_height / 2.0

	if is_top:
		pipe.global_position.y = gap_center_y - half_gap - half_pipe
	else:
		pipe.global_position.y = gap_center_y + half_gap + half_pipe

	
func init(MIN_GAP, MAX_GAP):
	var view_port := get_viewport()
	
	global_position.x = view_port.size.x
	
	gap = randi_range(MIN_GAP, MAX_GAP)
	#print("min: " + str(MIN_GAP) + ", max: " + str(MAX_GAP))
	#print(gap)
	
	offset = randi_range(150 + gap/2, view_port.size.y - 150 - gap/2) - view_port.size.y/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var view_port = get_viewport()

	width = low_pipe.get_node("CollisionShape2D").shape.get_rect().size.x * scale.x
	
	if gameManager.game_running:
		adjust_to_gap(low_pipe, gap,  offset, false)
		adjust_to_gap(high_pipe, gap, offset, true)
		if global_position.x < 0:
			queue_free()
		else:
			global_position.x += gameManager.game_speed * delta
