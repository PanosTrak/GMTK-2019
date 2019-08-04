extends Node

export(AudioStreamSample) var no_ghost
export(AudioStreamSample) var ghost_one 
export(AudioStreamSample) var ghost_two 
export(AudioStreamSample) var ghost_three 
export(AudioStreamSample) var ghost_four
export(AudioStreamSample) var ghost_five
export(AudioStreamSample) var ghost_six

onready var audio_to_play = no_ghost
onready var hud = get_node('../HUD')
onready var audio_player = $AudioStreamPlayer

var old_ghost_size

func get_ghost_size():
	return clamp(hud.getGhostNumber(), 0, 6)

func _ready():
	audio_player.play()


func _process(delta):
	var new_ghost_size = get_ghost_size()
	if new_ghost_size != old_ghost_size:
		match new_ghost_size:
			0:
				audio_to_play = no_ghost
			1:
				audio_to_play = ghost_one
			2:
				audio_to_play = ghost_two
			3:
				audio_to_play = ghost_three
			4:
				audio_to_play = ghost_four
			5:
				audio_to_play = ghost_five
			6:
				audio_to_play = ghost_six
		audio_player.set_stream(audio_to_play)
		audio_player.play()
		old_ghost_size = new_ghost_size

func _on_AudioStreamPlayer_finished():
	audio_player.play()