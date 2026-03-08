extends Node
@export var health = 10.0

func take_damage(dmg):
	health -= dmg
	print("took damage: " + str(dmg))
	if health <= 0:
		get_parent().queue_free()
