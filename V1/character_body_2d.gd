extends CharacterBody2D

@onready var player: CharacterBody2D = $player
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var speed=75

func _physics_process(delta:float):
	var direction = (player.position - position).normalized()
	velocity=direction*speed
	look_at(player.position)
	move_and_slide()
	
	
