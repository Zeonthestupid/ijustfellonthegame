@abstract 
extends Node2D
class_name base_attack

@export var damage = 0.0
@export var damageplayers: bool
@export var damageenemies: bool
@abstract func attack(angle: Vector2)
