extends CharacterBody2D

var packed_vec2_array: PackedVector2Array = PackedVector2Array()
@onready var player := $"../player"
@onready var health = $HealthComponent
@export var speed = 200.0
@export var num_directions: int = 8
@export var ray_length: float = 200.0



func _ready():
	add_to_group("enemies")
	for i in num_directions:
		var angle = (TAU / num_directions) * i
		directions.append(Vector2.from_angle(angle))
	


var directions: Array[Vector2] = []

func get_best_direction() -> Vector2:
	var player_dir = global_position.direction_to(player.global_position)
	
	var best_score = -INF
	var best_dir = Vector2.ZERO
	
	var space_state = get_world_2d().direct_space_state
	
	for dir in directions:
		var interest = dir.dot(player_dir)
		
		var query = PhysicsRayQueryParameters2D.create(
			global_position,
			global_position + dir * ray_length,
			collision_mask
		)
		query.exclude = [self]
		var result = space_state.intersect_ray(query)
		if result:
			var dist = global_position.distance_to(result.position)
			if dist < ray_length * 0.6:
				continue  
		
		if interest > best_score:
			best_score = interest
			best_dir = dir
	return best_dir

func _physics_process(delta):
	velocity = get_best_direction() * speed
	move_and_slide()



func take_damage(amount: int) -> void:
	print(amount)
	health.damage(amount)


func _on_health_component_died() -> void:
	remove_from_group("enemies")
	pass # Replace with function body.
