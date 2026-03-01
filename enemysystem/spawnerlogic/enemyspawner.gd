extends Node2D
class_name EnemySpawner

@export var enemy_scene: PackedScene
@export var spawn_particles: PackedScene

func _ready():
	add_to_group("enemy_spawner")

func spawn_group(group_name: String):
	if is_in_group(group_name):
		spawn_enemy(global_position)

func spawn_enemy(pos: Vector2):
	if spawn_particles:
		var p = spawn_particles.instantiate()
		p.global_position = pos
		get_tree().current_scene.add_child(p)
	var enemy = enemy_scene.instantiate()
	enemy.global_position = pos
	enemy.velocity = Vector2.ZERO
	get_tree().current_scene.add_child(enemy)
	
