extends AudioStreamPlayer

var curr_song: AudioStreamPlayer
var songs_left := []
var songs := []

func get_random_song():
	if songs_left.is_empty():
		songs_left = songs.duplicate()
		songs_left.shuffle()
	
	return songs_left.pop_back()
	

func next_song():
	curr_song = get_random_song()
	curr_song.play()

func _ready() -> void:
	for song in get_children(): songs.append(song)
	next_song()

func _process(delta: float) -> void:
	if Settings.bg_music_enabled and curr_song.stream_paused:
		curr_song.stream_paused = false
	elif not Settings.bg_music_enabled and not curr_song.stream_paused:
		curr_song.stream_paused = true
	elif not curr_song.playing:
		next_song()
