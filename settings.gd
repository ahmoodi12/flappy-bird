extends Node

# default values
var initial_gravity := 800.0
var initial_jump_velocity := -400.0
var base_speed := -150

var initial_min_gap := 250
var initial_max_gap := 350
var min_gap := 150

var bg_music_intensity := 0
var sound_effect_intensity := 0
var bg_music_enabled := true

var imm_respawn := false

var settings_file := "res://settings.json"
var loaded := false

func _ready():
	Settings.load_settings()
	

func save_settings():
	var file = FileAccess.open(settings_file, FileAccess.WRITE)

	var data = {
		"initial_gravity": initial_gravity,
		"initial_jump_velocity": initial_jump_velocity,
		"base_speed": base_speed,
		"initial_min_gap": initial_min_gap,
		"initial_max_gap": initial_max_gap,
		"min_gap": min_gap,
		"bg_music_intensity": bg_music_intensity,
		"sound_effect_intensity": sound_effect_intensity,
		"bg_music_enabled": bg_music_enabled,
		"imm_respawn": imm_respawn
	}

	file.store_string(JSON.stringify(data))


func load_settings():
	if not FileAccess.file_exists(settings_file):
		return

	var file = FileAccess.open(settings_file, FileAccess.READ)
	var text = file.get_as_text()

	var data = JSON.parse_string(text)
 	

	
	if data == null:
		save_settings()
		Settings.loaded = true
		return

	initial_gravity = data.get("initial_gravity", initial_gravity)
	initial_jump_velocity = data.get("initial_jump_velocity", initial_jump_velocity)
	base_speed = data.get("base_speed", base_speed)
	initial_min_gap = data.get("initial_min_gap", initial_min_gap)
	initial_max_gap = data.get("initial_max_gap", initial_max_gap)

	min_gap = data.get("min_gap", min_gap)
	bg_music_intensity = data.get("bg_music_intensity", bg_music_intensity)
	sound_effect_intensity = data.get("sound_effect_intensity", sound_effect_intensity)
	bg_music_enabled = data.get("bg_music_enabled", bg_music_enabled)
	imm_respawn = data.get("imm_respawn", imm_respawn)

	Settings.loaded = true
