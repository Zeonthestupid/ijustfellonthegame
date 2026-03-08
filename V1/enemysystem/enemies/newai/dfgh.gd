extends CharacterBody2D


var packed_vec2_array: PackedVector2Array = PackedVector2Array()
@onready var player := $"../player"
@onready var health = $HealthComponent
@onready var nav_agent = $NavigationAgent2D
@export var speed = 400.0
@export var num_directions: int = 8
@export var ray_length: float = 200.0

var next_path_pos

func _ready():
	add_to_group("enemies")
	nav_agent.target_position = player.global_position


func _physics_process(delta):
	print(player.position)
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	print(dir)
	velocity = dir * speed
	
	move_and_slide()
			
func take_damage(amount: int) -> void:
	print(amount)
	health.damage(amount)


func _on_health_component_died() -> void:
	remove_from_group("enemies")
	pass # Replace with function body.
