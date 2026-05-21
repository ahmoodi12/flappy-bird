extends Button

@export var UI: Node
@export var options_menu: Control

func _on_pressed() -> void:
	UI.open_menu(options_menu)
