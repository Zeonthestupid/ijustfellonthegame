extends CharacterBody2D

@export var damage = 5

const SPEED = 200
var time = 0.0
var rng = RandomNumberGenerator.new()
var power = 0.0
var attacktimer = 0.0

var at1 = false
var at2 = false
var at3 = false
@onready var player := $"../player"
@onready var health = $HealthComponent

func _ready():
	add_to_group("enemies")
func attack():
	var x = rng.randi_range(1, 3)
	if x == 2:
		at2 = true
		pass
	else:
		at2 = false
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	var direction = Vector2(0,0)
	time += delta
	if time > 1.0:
		time = 0.0
		attack()
	if at2:

		var tween = get_tree().create_tween()
		tween.tween_property(self, "power", 2.0, 0.1)
		tween.tween_property(self, "power", 0.0, 1.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		attacktimer = 1.0
		at2 = false
	
	
	if attacktimer>0.0:
		direction = position.direction_to(player.position)
		velocity.x = direction.x * power * SPEED
		velocity.y = direction.y * power * SPEED
		
		
		attacktimer -= delta
		if attacktimer<= 0.0:
			direction = Vector2.ZERO
	else:
		velocity.x = 0
		velocity.y = 0
	
		

	move_and_slide()

func take_damage(amount: int) -> void:
	print(amount)
	health.damage(amount)


func _on_health_component_died() -> void:
	remove_from_group("enemies")
	pass # Replace with function body.
