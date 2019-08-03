extends Node2D

signal stop

var time = 0
var states_position = 0
var positions_position = 0
var firstinrun = true
var positions_lenght = 0

var states = []
var positions = []

func _process(delta):
	time += delta

func _changeState(state): #saves when a diffrent animation State is triggered #state as String with name from the Animation State
	states[states_position] = time
	states_position += 1
	states[states_position] = state
	states_position += 1

func setPosition(pos): # pos = global_position from Player
	positions.append(pos)

func getPosition():
	var tmp = positions[positions_position]
	positions_position += 1
	if positions_position == positions_lenght:
		emit_signal("stop")
		print("Stop Signal")
	return tmp

func setLengthIntern():
	positions_lenght = positions.size()