extends Node

@export var start_menu: Control
@export var death_menu: Control
@export var pause_menu: Control
@export var game_ui: Control
@export var gameplay_settings: Control
@export var audio_settings: Control

var menu_stack: Array[Control] = []
var current_menu: Control = null

func fade_in(node: Control, time := 0.25):
	node.visible = true
	node.modulate.a = 0.0

	var tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 1.0, time)
	await tween.finished


func fade_out(node, time := 0.25):
	var tween = node.create_tween()
	tween.tween_property(node, "modulate:a", 0.0, time)
	await tween.finished

	node.visible = false


func open_menu(menu: Control, fade := 0.3):
	if current_menu == menu:
		return

	if current_menu:
		await fade_out(current_menu, fade)
		menu_stack.append(current_menu)

	current_menu = menu
	await fade_in(menu, fade)


func replace_menu(menu: Control, fade := 0.3):
	menu_stack.clear()

	if current_menu:
		await fade_out(current_menu, fade)

	current_menu = menu
	await fade_in(menu, fade)


func go_back(fade := 0.3):
	if menu_stack.is_empty():
		return

	var prev = menu_stack.pop_back()

	if current_menu:
		await fade_out(current_menu, fade)

	current_menu = prev
	await fade_in(current_menu, fade)


func close_all(fade := 0.3):
	if current_menu:
		await fade_out(current_menu, fade)

	current_menu = null
	menu_stack.clear()


func _on_gameplay_settings_btn_pressed() -> void:
	open_menu(gameplay_settings)


func _on_go_back_btn_pressed() -> void:
	go_back()


func _on_audio_settings_pressed() -> void:
	open_menu(audio_settings)


func _on_go_to_menu_btn_pressed() -> void:
	replace_menu(start_menu)
