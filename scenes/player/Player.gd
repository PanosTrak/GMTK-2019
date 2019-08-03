extends KinematicBody2D

export (Script) var Ghost_recording

const MAX_SPEED = 200
const ACCELERATION = 25
const GRAVITY = 500
const ON_WALL_GRAVITY = 125
const JUMP_LIMIT = -1000
const ON_WALL_JUMP_LIMIT = -450
const MASS = 15
const JUMP = -450
const STOP_ACCELERATION = 0.3
var velocity = Vector2()
var last_wall_jump_pos

func movement_input():

	if !is_on_wall():
		velocity.y = clamp(MASS + velocity.y, JUMP_LIMIT, GRAVITY) 
	else:
		velocity.y = clamp(MASS + velocity.y, ON_WALL_JUMP_LIMIT, ON_WALL_GRAVITY)


	# Get Input from player
	var move_pos = Vector2(0,0)
	if Input.is_action_pressed('move_right'):
		move_pos.x += 1
	if Input.is_action_pressed('move_left'):
		move_pos.x += -1
	if Input.is_action_just_pressed('jump') && is_on_floor():
		move_pos.y = JUMP
	if Input.is_action_just_pressed('jump') && is_on_wall():
		if last_wall_jump_pos == null:
			velocity.y = 0
			move_pos.y = JUMP
			last_wall_jump_pos = move_pos.x
		else:
			if last_wall_jump_pos != move_pos.x:
				move_pos.y = JUMP
				velocity.y = 0
				last_wall_jump_pos = move_pos.x
				
	
	if move_pos.x != 0:
		$AnimatedSprite.play("run")
		Ghost_recording.changeState("run") # saves when the animation changes
		if move_pos.x == 1:
			velocity.x = clamp(velocity.x + ACCELERATION, -MAX_SPEED, MAX_SPEED)
			$AnimatedSprite.flip_h = false
		else:
			velocity.x = clamp(velocity.x - ACCELERATION,-MAX_SPEED, MAX_SPEED)
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
		Ghost_recording.changeState("idle") # saves when the animation changes
		if velocity.x != 0:
			velocity.x = int(lerp(velocity.x, 0, STOP_ACCELERATION))

	if !is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
			Ghost_recording.changeState("jump") # saves when the animation changes
		else:
			$AnimatedSprite.play("fall")
			Ghost_recording.changeState("fall") # saves when the animation changes
	else:
		# Reset last wall jump position when player hit the ground
		last_wall_jump_pos = 0
		
	if is_on_floor():
		velocity.y = clamp(move_pos.y + velocity.y, JUMP_LIMIT, GRAVITY)
	elif is_on_wall():
		velocity.y = clamp(move_pos.y + velocity.y, ON_WALL_JUMP_LIMIT, ON_WALL_GRAVITY)

	velocity = move_and_slide(velocity, Vector2(0,-1))


func launch(speed):
	velocity.y += -speed

func _physics_process(delta):
	movement_input()
	Ghost_recording.setPosition(self.global_position) #sends the position into the Ghost_Sysdtem class