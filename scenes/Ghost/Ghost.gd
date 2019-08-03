extends KinematicBody2D

var states = []
var positions = []

var at_pos = 0
var length = 0
var run = false
var a = false
var b = false

func _ready():
	print("new Ghost Instance")

func _process(delta):
	if run:
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
	tmp.queue_free()
