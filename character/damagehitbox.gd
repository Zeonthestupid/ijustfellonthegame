extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
signal take_damage

func PLAYER():
	pass


func _on_body_entered(body):
	print("QWGIUHWQEGIUWEHGWOEUGHWOUGH")
	if body.has_method("enemy"):
		print("QWGIUHWQEGIUWEHGWOEghjiegjhgwgiweogUGHWOUGH")
		get_parent().take_damage(2)
