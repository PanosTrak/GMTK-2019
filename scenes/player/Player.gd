extends KinematicBody2D

const MAX_SPEED = 200
const ACCELERATION = 20
const GRAVITY = 15
const JUMP = -500
var velocity = Vector2()

func movement_input():

	# Add gravity
	velocity.y += GRAVITY

	# Get Input from player
	var move_pos = Vector2(0,0)
	if Input.is_action_pressed('move_right'):
		move_pos.x += 1
	if Input.is_action_pressed('move_left'):
		move_pos.x += -1
	if Input.is_action_pressed('jump') && is_on_floor():
		move_pos.y += JUMP
	
	if move_pos.x != 0:
		$AnimatedSprite.play("run")
		if move_pos.x == 1:
			velocity.x = clamp(velocity.x + ACCELERATION, -MAX_SPEED, MAX_SPEED)
			$AnimatedSprite.flip_h = false
		else:
			velocity.x = clamp(velocity.x - ACCELERATION,-MAX_SPEED, MAX_SPEED)
			print(velocity.x)
			$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("idle")
		if velocity.x != 0:
			velocity.x = int(lerp(velocity.x, 0, 0.25))

	if !is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
		
	velocity.y += move_pos.y
	velocity = move_and_slide(velocity, Vector2(0,-1))
	if velocity != Vector2(0,0):
		print(velocity)
	

func _physics_process(delta):
	movement_input()