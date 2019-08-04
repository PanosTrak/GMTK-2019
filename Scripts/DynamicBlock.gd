extends StaticBody2D

enum states { DEFAULT, FREEZER, SPIKES, JUMPER }

export(states) var starting_state

export(Texture) var default_img
export(Texture) var freezer_img
export(Texture) var spikes_img
export(Texture) var jumper_img

export(int) var jumper_power = 500
export(float) var freeze_time = 3.0

export(PackedScene) var freeze_particles

onready var state_texture = {
	0: default_img,
	1: freezer_img,
	2: spikes_img,
	3: jumper_img
}

var player
var ghost

onready var state = starting_state 

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed('change_dynamic_block'):
		if state != 3:
			state += 1
		else:
			state = 0
	$Sprite.set_texture(state_texture[state])

func _on_Area2D_body_entered(body):
	print("Entered")
	if body.is_in_group('player'):
		player = body
		match state:
			states.FREEZER:
				_start_freeze(player)
			states.SPIKES:
				player.die()
			states.JUMPER:
				player.launch(jumper_power)



func _on_ChangeStateArea2D_body_entered(body):
	if body.is_in_group('player') && body.is_on_ceiling():
		if $AnimationPlayer.get_current_animation() == 'bumped':
			$AnimationPlayer.stop()
		$AnimationPlayer.set_current_animation('bumped')
		if state != 3:
			state += 1
		else:
			state = 0

func _start_freeze(object):
	$FreezeTimer.start(freeze_time)
	object.freeze()
	var freeze_particles_inst = freeze_particles.instance()
	add_child(freeze_particles_inst)
	freeze_particles_inst.set_global_position($ParticleSpawnPosition.get_global_position())
	freeze_particles_inst.set_emitting(true)

func _on_FreezeTimer_timeout():
	$FreezeTimer.stop()
	player.unfreeze()


func _on_Area2D_area_entered(area):
	var g = area.get_parent()
	if g.is_in_group('Ghost'):
		print("its a ghost")
		ghost = g
		match state:
			states.FREEZER:
				_start_freeze(ghost)
			states.SPIKES:
				ghost.die()
