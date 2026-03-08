extends CharacterBody2D

# Jump curves, Player forgiveness, Run curves, Dash only affects movement temporarily

# Player running
@export_subgroup("runningfactors")
@export var max_run_speed = 400.0
@export var run_acceleration_time = 3 # frames
@export var run_deceleration_time = 2 # frames
@export var player_starting_speed = 0

var runstate = 0
var currentspeed = 0
var acceleration_timer = 0


@export_subgroup("jumppingfactors")
@export var max_jump_speed = 800
@export var gravity_deceleration_factor = 0.5
@export var jump_up = 1900
@export var jump_down = 2900
@export var fast_fall_multiplier = 1.5


var current_jump_speed = 0


# Player Forgiveness
var coyote_timer = 0
@export var coyote_frames = 0

var prevdirection = 0.0
var currentjumpspeed = 0.0

var knockback_velocity: Vector2 = Vector2.ZERO
var kb_timer := 0
var kb_sustain_frames := 0
var kb_decay_frames := 0
var player_lock_frames = 0
var fastfalling = false
var cutjump = false


func _physics_process(delta: float) -> void:
	# TEMP TEMP TEMP TODO 
	# Input detection / handling
	if Input.is_action_just_pressed("player_down"):
		fastfalling = true
	if Input.is_action_just_released("player_down"):
		fastfalling = false
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = -max_jump_speed
	
	var fastfallmp = (fast_fall_multiplier if fastfalling else 1.0)
	
	# Jumping
	if velocity.y < 0:
		velocity.y += jump_up * delta * (fastfallmp)
		if cutjump:
			velocity.y = 0
	else:
		
		velocity.y += jump_down * delta * fastfallmp
	
	
	# Movement
	var direction := Input.get_axis("player_left", "player_right")
	
	
	if kb_timer >= player_lock_frames:
		if direction: # check if moving
			currentspeed = min(currentspeed + max_run_speed/run_acceleration_time, max_run_speed)
			velocity.x = currentspeed * direction
			prevdirection = direction
		else:
			currentspeed = max(currentspeed - max_run_speed/run_deceleration_time, 0)
			velocity.x = currentspeed * prevdirection
	else:
		print("locked")
	
	velocity += knockback_velocity
	if kb_timer < kb_sustain_frames:
		velocity += knockback_velocity

	elif kb_timer < kb_sustain_frames + kb_decay_frames:
		var decay_progress = float(kb_timer - kb_sustain_frames) / kb_decay_frames
		velocity += knockback_velocity * (1.0 - decay_progress)
	else:
		knockback_velocity = Vector2.ZERO

	kb_timer += 1
	move_and_slide()
	

func apply_knockback(direction: Vector2, strength: float, sustain: int, decay: int, player_lock: int):
	knockback_velocity = direction.normalized() * strength
	kb_timer = 0
	kb_sustain_frames = sustain
	kb_decay_frames = decay
	player_lock_frames = player_lock
	
	
