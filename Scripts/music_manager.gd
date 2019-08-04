extends Node

export(AudioStreamSample) var no_ghost
export(AudioStreamSample) var ghost_one 
export(AudioStreamSample) var ghost_two 
export(AudioStreamSample) var ghost_three 
export(AudioStreamSample) var ghost_four
export(AudioStreamSample) var ghost_five
export(AudioStreamSample) var ghost_six

onready var audio_to_play = no_ghost

var old_ghost_size = 0

func get_ghost_size():
	return rand_range(0,6)

func _ready():
	pass


func _process(delta):
	match get_ghost_size():
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