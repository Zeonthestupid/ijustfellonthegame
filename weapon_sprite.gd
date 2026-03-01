extends Sprite2D


func _input(event):
	if Input.is_action_just_pressed("trident_test"):
		var knockback_direction = get_global_mouse_position().normalized()
		trident(knockback_direction, 150.0, 0.12)
