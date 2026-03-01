extends Node2D
@export var max_health: float = 10.0
var health := max_health

signal died

func damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		health = 0
		died.emit()
		get_parent().queue_free()
