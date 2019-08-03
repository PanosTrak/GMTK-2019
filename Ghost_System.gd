extends Node2D

signal stop

var anim_Sprite

var time = 0
var states_position = 0
var positions_position = 0
var firstinrun = true
var positions_lenght = 0
var nextAnimationChange = 0
var currentState = "idle"

var states = []
var positions = []

func _process(delta):
	time += delta

func changeState(state): #saves when a diffrent animation State is triggered #state as String with name from the Animation State
	if currentState != state:
		states.append(time)
		states.append(state)

func setPosition(pos): # pos = global_position from Player
	positions.append(pos)

func getPosition():
	checkAnimation()
	var tmp = positions[positions_position]
	positions_position += 1
	if positions_position == positions_lenght:
		emit_signal("stop")
		print("Stop Signal")
	return tmp

func startGhost():
	nextAnimationChange = states[0]
	states_position = 1
	time = 0
	setLengthIntern()

func setAnimatedSprite(sprite):
	anim_Sprite = sprite

func setLengthIntern():
	positions_lenght = positions.size()

func checkAnimation():
	if time >= nextAnimationChange:
		anim_Sprite.play(states[states_position])
		states_position += 1
		nextAnimationChange = states[states_position]
		states_position += 1

func hitCheckPoint():
	print("Hit Ckeckpoint")



