extends CanvasLayer

var checkpoints_done = 0
var checkpoints_all = 3
var level_name = "Level name here"
var number_ghosts = 0

func _ready():
	$Checkpoint_Done.set_text("0")

func setName(name):
	level_name = name
	$Level.set_text(level_name)
	
func setScore(number):
	checkpoints_done = number
	$Checkpoint_Done.set_text(str(checkpoints_done))

func setScoreMax(number):
	checkpoints_all = number
	$Checkpoint_All.set_text(str(checkpoints_all))

func increaseScore():
	checkpoints_done += 1
	$Checkpoint_Done.set_text(str(checkpoints_done))

func increaseGhosts():
	number_ghosts += 1

func getGhostNumber():
	return number_ghosts

func win():
	if checkpoints_done == checkpoints_all:
		return true
	else:
		return false