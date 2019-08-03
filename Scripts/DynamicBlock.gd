extends StaticBody2D

enum states { FREEZER, SPIKES, JUMPER }

export(states) var starting_state

export(Texture) var freezer_img
export(Texture) var spikes_img
export(Texture) var jumper_img

export(int) var jumper_power = 500

onready var state_texture = {
	0: freezer_img,
	1: spikes_img,
	2: jumper_img
}

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
	match state:
		states.FREEZER:
			# TODO do something with freezer
			pass
		states.SPIKES:
			body.die()
		states.JUMPER:
			body.launch(jumper_power)