extends CollisionShape2D

@export var damage = 5

func _on_body_entered(body):
	print("ENTERED@!@@11!!!1!1!!")
	if body.has_method("PLAYER"):
		body.take_damage(damage)
		
func enemy():
	pass
