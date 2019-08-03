extends Node2D

export (PackedScene) var Save

var startingposition 
var active = true

var speed = 0
var jump = false
var jumpspeed = 0
var save_instance

func _ready():
	save_instance = Save.instance()
	startingposition = self.position

func _process(delta):
	if active:
		save_instance.setPosition(self.global_position)
		if jump:
			move_local_y(jumpspeed * delta)
		move_local_x(speed * delta)
	else:
		save_instance.setLengthIntern()
		self.global_position = save_instance.getPosition()

func _input(event):
	if(event.is_action("Player_left")):
		speed = -150
	if(event.is_action("Player_right")):
		speed = 150
	if(event.is_action("Player_up")):
		$JumpTimer.start()
		jump = true
		jumpspeed = -150
	if(event.is_action("Player_standing")):
		speed = 0

func _startfalling():
	$FallTimer.start()
	jumpspeed = 150

func _stopfalling():
	jump = false
	jumpspeed = 0

func _on_Area2D_area_entered(area):
	active = false
	
