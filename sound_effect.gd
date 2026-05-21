extends AudioStreamPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	volume_db = Settings.sound_effect_intensity
