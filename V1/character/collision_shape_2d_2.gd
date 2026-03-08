extends CollisionShape2D

signal music_change

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_body_entered(body):
	if body.has_method("enemy"):
		music_change.emit()
		

func _on_body_exited(body):
	if body.has_method("enemy"):
		music_change.emit()
