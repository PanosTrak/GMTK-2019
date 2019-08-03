extends KinematicBody2D

export (PackedScene) var Save

const MAX_SPEED = 200
const ACCELERATION = 25
const GRAVITY = 25
const JUMP = 400

var velocity = Vector2()

var save_instance
var startingposition 
var active = true

func _ready():
	save_instance = Save.instance()
	startingposition = self.position
	save_instance.setAnimatedSprite($AnimatedSprite)

func get_input():
	var action = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if Input.is_action_just_pressed("ui_up") && is_on_floor():
		velocity.y = -JUMP
	
	if action != 0 && is_on_floor():
		$AnimatedSprite.play("run")
		save_instance.changeState("run")
		velocity.x += ACCELERATION if action > 0 else -ACCELERATION
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		
		$AnimatedSprite.flip_h = action < 0
	elif !is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite.play("jump")
			save_instance.changeState("jump")
		else:
			$AnimatedSprite.play("fall")
			save_instance.changeState("fall")
			
		velocity.x = lerp(velocity.x, 0, 0.01)
	else:
		$AnimatedSprite.play("idle")
		save_instance.changeState("idle")
		velocity.x = lerp(velocity.x, 0, 0.3)
		
func set_gravity():
	velocity.y += 10

func _physics_process(delta):
	set_gravity()
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _process(delta):
	if active:
		save_instance.setPosition(self.global_position)
	else:
		save_instance.setLengthIntern()
		self.global_position = save_instance.getPosition()

func _on_Area2D_area_entered(area):
	active = false
	save_instance.startGhost()