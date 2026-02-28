extends Node2D
@export var speedstuff = 500000
@export var accelerationfactor = 250
var SPEED: int = 7000
var acceleration = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.x * max(SPEED + acceleration, 0) * delta 
	if acceleration >= -25000:
		acceleration -= accelerationfactor


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
