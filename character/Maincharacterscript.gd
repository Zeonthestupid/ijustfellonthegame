extends CharacterBody2D

@export_category("Character params")
@export_subgroup("Main config")
@export var speed_mod = 0.4
@export var swimming_amp = 2.0

@export var max_speed = 500

@export_subgroup("Swim config")
@export var clamping_speed = 0.5 
@export var swim_back = 0.02

@export_subgroup("characterconf")
@export var heath = 10.0

@export_subgroup("kb")
@export var kbfactor = 1000
@export var kbtime = 1.0


@export var weapons: Array[Node2D]
@export var currentweapon = 0
var knockback: Vector2 = Vector2.ZERO
var knockback_timer: float = 0.0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var shotangle = 0.0
var shot = false

var time = 0.0

var power = 0.0
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
	var velo = Vector2(0,0)
	
	if Input.is_action_just_pressed("trident_test"):
		knockback = Vector2(cos((get_global_mouse_position() - global_position).angle())*kbfactor, sin((get_global_mouse_position() - global_position).angle())*kbfactor)
		print(knockback)
		knockback_timer = kbtime
		var tween = get_tree().create_tween()
		tween.tween_property(self, "power", 1.0, 0.1)
		tween.tween_property(self, "power", 0.0, 1.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		
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
	
	move_and_slide()


func _on_sprite_2d_hooked(hooked_position: Variant) -> void:
	var tween = get_tree().create_tween()
	var dist = sqrt(pow(hooked_position.y - global_position.y, 2)+pow(hooked_position.x - global_position.x, 2))
	dist = dist * 0.01
	print(dist)
	tween.tween_property(self, "position", hooked_position, 0.2*dist)
	


	
