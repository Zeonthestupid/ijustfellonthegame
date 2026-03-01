extends CharacterBody2D


const SPEED = 2
var time = 0.0
var rng = RandomNumberGenerator.new()

var at1 = false
var at2 = false
var at3 = false


func attack():
	var x = rng.randi_range(1, 3)
	if x == 2:
		at2 = true
		pass
	else:
		at2 = false
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	time += delta
	if time > 1.0:
		time = 0.0
		attack()
	if at2:
		velocity = get_global_mouse_position() * SPEED
		at2 = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
