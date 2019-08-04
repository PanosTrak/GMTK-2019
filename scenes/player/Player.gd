extends KinematicBody2D

export (PackedScene) var Ghost_Scene
export (PackedScene) var freeze_particles

export (AudioStreamSample) var footstep_1 
export (AudioStreamSample) var footstep_2
export (AudioStreamSample) var landing
export (AudioStreamSample) var freezing

const MAX_SPEED = 200
const ACCELERATION = 25
const GRAVITY = 500
const ON_WALL_GRAVITY = 125
const JUMP_LIMIT = -1000
const ON_WALL_JUMP_LIMIT = -450
const MASS = 15
const JUMP = -500
const STOP_ACCELERATION = 0.3
var velocity = Vector2()
var last_wall_jump_pos
var Ghost_recording
var is_dead = false
var is_frozen = false

onready var footstep_player = get_node('FootstepPlayer')
onready var freezing_player = get_node('FreezingPlayer')
onready var landing_player = get_node('LandingPlayer')

func _ready():
	Ghost_recording = Ghost_Scene.instance()
	add_child(Ghost_recording)

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
	if velocity.x != 0 && is_on_floor():
		var rand_step = randi()
		var step_sound
		if rand_step % 2:
			step_sound = footstep_1
		else:
			step_sound = footstep_2
		if !footstep_player.is_playing() || footstep_player.get_playback_position() > 0.40:
			footstep_player.set_stream(step_sound)
			footstep_player.play()


func launch(speed):
	velocity.y += -speed

func die():
	is_dead = true
	$AnimatedSprite.hide()
	$Area2D.queue_free()

func freeze():
	is_frozen = true
	freezing_player.set_stream(freezing)
	freezing_player.play()
	$AnimatedSprite.set_self_modulate(Color(0.1, 1, 1, 1))

func unfreeze():
	is_frozen = false
	$AnimatedSprite.set_self_modulate(Color(1, 1, 1, 1))
	var freeze_particles_inst = freeze_particles.instance()
	add_child(freeze_particles_inst)
	freeze_particles_inst.set_global_position(get_global_position())
	freeze_particles_inst.set_emitting(true)

func _physics_process(delta):
	if !is_dead && !is_frozen:
		movement_input()
	Ghost_recording.setPosition(self.global_position) #sends the position into the Ghost_Sysdtem class

func _hitCheckpoint(area):
	print("Hit Something")
	Ghost_recording.hitCheckPoint(area)
