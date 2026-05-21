extends Node

@export var UI: Node

@export var bird: CharacterBody2D
@export var pipes: Node2D
@export var pipe_pair_scene: PackedScene

@export var score_label: Label
@export var final_score_label: Label
@export var point_sound: AudioStreamPlayer

@export var start_menu: Control
@export var death_menu: Control
@export var pause_menu: Control
@export var game_ui: Control

var game_running := false

var gravity: int
var jump_vel: int
var curr_max_gap: int
var curr_min_gap: int

var game_speed := 0
var score := 0

var last_obstacle: Node2D = null
var gap_between_poles := 450

var start_token := 0
func start_game():
	start_token += 1
	var my_token = start_token

	reset_game_state()

	await UI.replace_menu(game_ui, 0.2)

	if my_token != start_token:
		return

	bird.sprite.visible = true
	bird.sprite.modulate.a = 1.0
	bird.pop_sound.play()

	await get_tree().create_timer(0.5).timeout

	if my_token != start_token:
		return

	if UI.current_menu == UI.pause_menu:
		return

	game_running = true
	game_speed = Settings.base_speed

func pause_game():
	game_running = false
	UI.open_menu(pause_menu)


func resume_game():
	game_running = true
	UI.go_back()


func game_over():
	game_running = false
	final_score_label.text = "final score: " + str(score)
	
	if Settings.imm_respawn:
		start_game()
	else:
		UI.replace_menu(death_menu)
		await UI.fade_out(bird.sprite)


func reset_game_state():
	for c in pipes.get_children():
		c.free()

	reset_bird()
	
	score = 0
	gravity = Settings.initial_gravity
	jump_vel = Settings.initial_jump_velocity
	curr_max_gap = Settings.initial_max_gap
	curr_min_gap = Settings.initial_min_gap
	

func reset_bird():
	bird.sprite.visible = false
	bird.position = bird.start_pos
	bird.global_rotation_degrees = 0
	bird.velocity = Vector2.ZERO
	bird.speed_y = 0.0
	bird.move_and_slide()


func increment_score():
	score += 1
	game_speed -= 5
	gravity += 5
	jump_vel -= 5
	curr_max_gap -= 2
	curr_min_gap = max(curr_min_gap - 2, Settings.min_gap)


func _ready() -> void:
	while not Settings.loaded:
		pass

	UI.open_menu(start_menu, 0.5)


func _process(delta):
	score_label.text = "score: " + str(score)

	if not game_running:
		return

	for pipe_pair in pipes.get_children():
		if not pipe_pair.scored and pipe_pair.global_position.x < bird.global_position.x:
			increment_score()
			point_sound.play()
			pipe_pair.scored = true

		if pipe_pair.global_position.x < bird.global_position.x - 200:
			pipe_pair.fade()

	if last_obstacle == null or last_obstacle.global_position.x < \
		get_viewport().size.x - gap_between_poles - last_obstacle.width:
		last_obstacle = pipe_pair_scene.instantiate()
		last_obstacle.gameManager = self
		pipes.add_child(last_obstacle)
		last_obstacle.init(curr_min_gap, curr_max_gap)


func _on_start_btn_pressed() -> void:
	start_game()


func _on_continue_btn_pressed() -> void:
	resume_game()

func _on_restart_btn_pressed() -> void:
	start_game()

func _on_pause_btn_pressed() -> void:
	start_token += 1
	pause_game()

func _on_go_to_menu_btn_pressed() -> void:
	game_running = false
	reset_game_state()

	UI.replace_menu(start_menu) 
