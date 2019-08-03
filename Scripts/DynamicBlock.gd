extends StaticBody2D

enum states { FREEZER, SPIKES, JUMPER }

export(states) var starting_state

export(Texture) var freezer_img
export(Texture) var spikes_img
export(Texture) var jumper_img

export(int) var jumper_power = 500
export(float) var freeze_time = 3.0


onready var state_texture = {
	0: freezer_img,
	1: spikes_img,
	2: jumper_img
}

var player

onready var state = starting_state 

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed('change_dynamic_block'):
		if state != 2:
			state += 1
		else:
			state = 0
	$Sprite.set_texture(state_texture[state])

func _on_Area2D_body_entered(body):
	if body.is_in_group('player'):
		player = body
		match state:
			states.FREEZER:
				_start_freeze()
			states.SPIKES:
				player.die()
			states.JUMPER:
				player.launch(jumper_power)

func _start_freeze():
	$FreezeTimer.start(freeze_time)
	player.freeze()

func _on_FreezeTimer_timeout():
	$FreezeTimer.stop()
	player.unfreeze()
