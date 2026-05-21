extends Control

@export var jump_sens_val: HSlider
@export var gravity_val: HSlider
@export var difficulty_val: HSlider
@export var sound_effect_DB_val: HSlider
@export var bg_music_DB_val: HSlider
@export var bg_music_enabled: CheckBox
@export var imm_respawn: CheckBox
@export var game_speed_val: HSlider

func _ready() -> void:
	while not Settings.loaded:
		pass
		
	load_values()


func load_values() -> void:
	jump_sens_val.value = -Settings.initial_jump_velocity
	gravity_val.value = Settings.initial_gravity
	difficulty_val.value = -Settings.base_speed

	sound_effect_DB_val.value = Settings.sound_effect_intensity
	bg_music_DB_val.value = Settings.bg_music_intensity
	bg_music_enabled.button_pressed = Settings.bg_music_enabled
	imm_respawn.button_pressed = Settings.imm_respawn
	game_speed_val.value = -Settings.base_speed


func save_setting(setting_name: String, value) -> void:
	Settings.set(setting_name, value)
	Settings.save_settings()


func _on_jump_sens_val_drag_ended(value_changed: bool) -> void:
	if value_changed:
		save_setting("initial_jump_velocity", -jump_sens_val.value)


func _on_gravity_drag_ended(value_changed: bool) -> void:
	if value_changed:
		save_setting("initial_gravity", gravity_val.value)


func _on_difficulty_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var gap = max(400 - difficulty_val.value*0.1, 180)
		save_setting("initial_min_gap", gap)
		save_setting("initial_max_gap", gap + 250)
	

func _on_sound_effect_intensity_drag_ended(value_changed: bool) -> void:
	if value_changed:
		save_setting("sound_effect_intensity", sound_effect_DB_val.value)


func _on_bg_music_toggled(toggled_on: bool) -> void:
	save_setting("bg_music_enabled", toggled_on)


func _on_bg_music_intensity_drag_ended(value_changed: bool) -> void:
	if value_changed:
		save_setting("bg_music_intensity", bg_music_DB_val.value)


func _on_imm_respawn_toggled(toggled_on: bool) -> void:
	save_setting("imm_respawn", toggled_on)


func _on_game_speed_drag_ended(value_changed: bool) -> void:
	if value_changed:
		save_setting("base_speed", -game_speed_val.value)
