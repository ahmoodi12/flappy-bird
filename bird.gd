extends CharacterBody2D

@export var game_manager: Node
@export var jump_sound: AudioStreamPlayer
@export var death_sound: AudioStreamPlayer
@export var pop_sound: AudioStreamPlayer
@export var sprite: Sprite2D

var speed_y := 0.0
var start_pos: Vector2


func _ready():
	var view_port = get_viewport()
	position = Vector2(0, -view_port.size.y/8)
	start_pos = position
	velocity.x = 0

func _physics_process(delta: float):
	var view_port = get_viewport()
	
	if not game_manager.game_running:
		return
	
	global_rotation_degrees = max(-90, min(90, speed_y * 0.1)) 
	
	if get_slide_collision_count():
		death_sound.play()
		await game_manager.game_over()
		
	if global_position.y < 0:
		global_position.y = 0
		speed_y = 0
		return  
	elif Input.is_action_just_pressed("jump"):
		jump_sound.play()
		speed_y = game_manager.jump_vel
	else:
		speed_y += game_manager.gravity * delta

	velocity.y = speed_y
	move_and_slide()
