extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
signal take_damage

func PLAYER():
	pass


func _on_body_entered(body):
	if body.has_method("enemy"):
		take_damage.emit()
