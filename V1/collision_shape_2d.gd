extends CollisionShape2D
const PARTICLE = preload("res://ui/bubble_pop.tscn")
@onready var timer: Timer = $"../../Timer"

func Oxygen_bubble():
	pass
	

func _on_body_entered(body):
	await timer.timeout
	if body.has_method("PLAYER"):
		Global.Oxygen_recharge = true
		print("oxygen refilled")
		var particle = PARTICLE.instantiate()
		get_tree().root.add_child(particle)
		timer.start()
		Global.Oxygen_recharge=false
		
