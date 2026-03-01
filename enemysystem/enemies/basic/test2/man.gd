extends CharacterBody2D


@onready var player := $"../player"
@onready var health = $HealthComponent
@export var speed = 200
func _ready():
	add_to_group("enemies")

	
func _physics_process(delta: float) -> void:
	var playerdir = global_position.direction_to(player.global_position)
	# Add the gravity.
	var direction = Vector2(0,0)
	
	velocity = direction * speed
		

	move_and_slide()



func take_damage(amount: int) -> void:
	print(amount)
	health.damage(amount)


func _on_health_component_died() -> void:
	remove_from_group("enemies")
	pass # Replace with function body.
