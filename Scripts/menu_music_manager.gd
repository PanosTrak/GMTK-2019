extends Node

func _ready():
	pass

func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play() 