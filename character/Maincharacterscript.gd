extends CharacterBody2D
@onready var reload: Timer = $reload
@onready var calm: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var combat: AudioStreamPlayer2D = $AudioStreamPlayer2D2
var calmmusic = true
var calmdb = 0.0
var combdb = -90.0

@export_category("Character params")
@export_subgroup("Main config")
@export var speed_mod = 0.4
@export var swimming_amp = 2.0

@export var max_speed = 500

@export_subgroup("Swim config")
@export var clamping_speed = 0.5 
@export var swim_back = 0.02

@export_subgroup("characterconf")
@export var heath = 5.0 

@onready var player := $"../player"
@onready var health = $HealthComponent

@export_subgroup("kb")
@export var kbfactor = 1000
@export var kbtime = 1.0

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

func _ready():
	weaponshandler.knockback.connect(_apply_knockback)
	
func swim(delta, velo) -> Vector2:
	var direction = Vector2(0,0)
	direction.x = Input.get_axis("player_left", "player_right")
	direction.y = Input.get_axis("player_up", "player_down")
	direction = direction.normalized()
	
	if direction.x != 0 or direction.y !=0:
		animated_sprite_2d.play("swim")
		time += delta
		var multiplier = max((sin(time * swimming_amp * PI) + clamping_speed) / 2.0, 0) - swim_back
		velo.x += direction.x * (max_speed * multiplier) * speed_mod
		velo.y += direction.y * (max_speed * multiplier) * speed_mod
	else:
		velo.x = move_toward(velocity.x, 0.25, max_speed)
		velo.y = move_toward(velocity.y, 0.25, max_speed)
		animated_sprite_2d.play("idle")
	return velo

func increase_weapon():
	currentweapon = (currentweapon + 1) % weapons.size()
func decrease_weapon():
	currentweapon = (currentweapon - 1) % weapons.size()

func _physics_process(delta):
	tridenttime -= delta
	calm.volume_db = calmdb
	combat.volume_db = combdb
	startingoxygen -= delta * oxygenfactor
	print(startingoxygen)
	var velo = Vector2(0,0)
	
	if Input.is_action_just_pressed("trident_test") and tridenttime <= 0:
		tridenttime = tridentcooldown
		knockback = Vector2(cos((get_global_mouse_position() - global_position).angle())*kbfactor, sin((get_global_mouse_position() - global_position).angle())*kbfactor)
		print(knockback)
		knockback_timer = kbtime
		var tween = get_tree().create_tween()
		tween.tween_property(self, "power", 1.0, 0.1)
		tween.tween_property(self, "power", 0.0, 1.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(0.5).timeout
		
	if knockback_timer>0.0:
		velocity.x = knockback.x * power
		velocity.y = knockback.y * power
		knockback_timer -= delta
		if knockback_timer<= 0.0:
			knockback = Vector2.ZERO
	else:
		velo = swim(delta, velo)
		velocity.x = velo.x
		velocity.y = velo.y
	
	if startingoxygen<= 0.0:
		startingoxygen=0.0
		Engine.time_scale = 0.2
		reload.start()
		
	if Global.Oxygen_recharge == true:
		startingoxygen += startingoxygen + 100
		
	
	
	move_and_slide()


func _on_sprite_2d_hooked(hooked_position: Variant) -> void:
	var tween = get_tree().create_tween()
	var dist = sqrt(pow(hooked_position.y - global_position.y, 2)+pow(hooked_position.x - global_position.x, 2))
	dist = dist * 0.01
	print(dist)
	tween.tween_property(self, "position", hooked_position, 0.2*dist)
	

func _apply_knockback(kb, kbtimer):
	knockback = kb
	knockback_timer = kb
	pass
func apply_knockback(kb, tweenin, tweenout):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "power", 1.0, tweenin)
	tween.tween_property(self, "power", 0.0, tweenout).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	print("kb")
	print(kb)
	knockback = kb
	knockback_timer = tweenin+tweenout
	pass
func updatekbpower(kbpower):
	power = kbpower
	
func take_damage(amount: int) -> void:
	print("damagetaken")
	startingoxygen -= 100
	var x = Vector2(-cos((get_global_mouse_position() - global_position).angle())*kbfactor, -sin((get_global_mouse_position() - global_position).angle())*kbfactor)
	apply_knockback(x, 0.25, 0.5)



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
		




func _on_reload_timeout() -> void:
		get_tree().reload_current_scene()


func _on_collision_shape_2d_2_music_change() -> void:
	switchaudio()
