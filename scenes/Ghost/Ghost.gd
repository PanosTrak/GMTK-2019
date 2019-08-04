extends KinematicBody2D

export (PackedScene) var freeze_particles

var states = []
var positions = []

var at_pos = 0
var length = 0
var run = false
var a = false
var b = false
var is_frozen = false

func _ready():
	print("new Ghost Instance")

func _process(delta):
	if is_frozen:
		self.global_position = positions[at_pos]
	elif run:
		self.global_position = positions[at_pos]
		if at_pos < length:
			at_pos += 1
		else:
			at_pos = 0
			#run = false
		checkAnimation()
	#print("O")

func setStates(pStates):
	states = pStates
	a = true
	r()

func setPositions(pos):
	positions = pos
	length = positions.size()
	b = true
	r()

func r():
	if a && b:
		run = true

func checkAnimation():
	pass

func _hit_player(area):
	var tmp = area.get_parent()
	if tmp.is_in_group('player'):
		print("Hit Player")
		tmp.die()

func freeze():
	is_frozen = true
	$FreezeTimer.start()
	$Ghost_animation.set_self_modulate(Color(0.1, 1, 1, 1))

func unfreeze():
	is_frozen = false
	$Ghost_animation.set_self_modulate(Color(1, 1, 1, 1))
	var freeze_particles_inst = freeze_particles.instance()
	add_child(freeze_particles_inst)
	freeze_particles_inst.set_global_position(get_global_position())
	freeze_particles_inst.set_emitting(true)

func die():
	queue_free()





	
