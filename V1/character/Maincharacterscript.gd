class_name Player

extends CharacterBody2D
@onready var reload: Timer = $reload
@onready var calm: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var combat: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var label: Label = $Label
var calmmusic = true
var calmdb = 0.0
var combdb = -90.0

@onready var player := $"../player"
@onready var health = $HealthComponent

@export_subgroup("oxygen")


@export var weapons: Array[Node2D]
@export var currentweapon = 0
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var weaponshandler: Node2D = $weaponshandler
var startingoxygen = 200
var oxygenfactor = 1.0
var shotangle = 0.0
var shot = false

var time = 0.0

var power = 0.0

var tridenttime = 2.5

var tridentcooldown = 2.0



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

func increase_weapon():
	currentweapon = (currentweapon + 1) % weapons.size()
func decrease_weapon():
	currentweapon = (currentweapon - 1) % weapons.size()


func _physics_process(delta: float) -> void:
	
	# Input detection / handling
	if Input.is_action_just_pressed("player_down"):
		fastfalling = true
	if Input.is_action_just_released("player_down"):
		fastfalling = false
	if is_on_floor() and Input.is_action_just_pressed("player_jump"):
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
	
	
	if kb_timer > player_lock_frames:
		if direction: # check if moving
			currentspeed = min(currentspeed + max_run_speed/run_acceleration_time, max_run_speed)
			velocity.x = currentspeed * direction
			prevdirection = direction
		else:
			currentspeed = max(currentspeed - max_run_speed/run_deceleration_time, 0)
			velocity.x = currentspeed * prevdirection
	else:
		print("locked")

	if Input.is_action_just_pressed("kbtest"):
		print("kb")
		apply_knockback(Vector2.LEFT, 1000, 6, 6, 4)
	
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
	
	

func _on_sprite_2d_hooked(hooked_position: Variant) -> void:
	var tween = get_tree().create_tween()
	var dist = sqrt(pow(hooked_position.y - global_position.y, 2)+pow(hooked_position.x - global_position.x, 2))
	dist = dist * 0.01
	print(dist)
	tween.tween_property(self, "position", hooked_position, 0.2*dist)


func PLAYER():
	pass

func switchaudio():
	calmmusic = !calmmusic
	if calmmusic:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "calmdb", 0.0, 0.2)
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self, "combdb", -40.0, 0.5).set_ease(Tween.EASE_IN)
	else:
		var tween2 = get_tree().create_tween()
		tween2.tween_property(self, "combdb", 0.0, 0.2)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "calmdb", -40.0, 1).set_ease(Tween.EASE_IN)
		

func heal() -> void:
	startingoxygen += 10


func _on_reload_timeout() -> void:
		get_tree().reload_current_scene()


func _on_collision_shape_2d_2_music_change() -> void:
	switchaudio()
	
	
func take_damage(hi):
	pass
