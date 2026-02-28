extends RigidBody2D
@export var speedstuff = 500000
@export var accelerationfactor = 90
var SPEED: int = 5000
var acceleration = 0
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	time += delta
	global_position += transform.x * max(SPEED + acceleration, 0) * delta 
	if acceleration >= -25000:
		acceleration -= accelerationfactor
	if time > 10:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
