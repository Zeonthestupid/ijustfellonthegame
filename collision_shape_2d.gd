extends CollisionShape2D
const PARTICLE = preload("res://ui/bubble_pop.tscn")

func Oxygen_bubble():
	pass
	

func _on_body_entered(body):
	if body.has_method("PLAYER"):
		Global.Oxygen_recharge = true
		var particle = PARTICLE.instantiate()
		get_tree().root.add_child(particle)
		
