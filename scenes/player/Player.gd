extends KinematicBody2D

const MAX_SPEED = 200
const ACCELERATION = 25
const GRAVITY = 25
const JUMP = 400

var velocity = Vector2()

func get_input():
	var action = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		velocity.y = -JUMP
	
	if action != 0 && is_on_floor():
		$AnimatedSprite.play("run")
		velocity.x += ACCELERATION if action > 0 else -ACCELERATION
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		
		$AnimatedSprite.flip_h = action < 0
	elif !is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
			
		velocity.x = lerp(velocity.x, 0, 0.01)
	else:
		$AnimatedSprite.play("idle")
		velocity.x = lerp(velocity.x, 0, 0.3)
		
func set_gravity():
	velocity.y += 10

func _physics_process(delta):
	set_gravity()
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))