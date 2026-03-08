extends base_attack
class_name base_melee


@export var rangearea: NodePath
@onready var rangebox: Area2D = get_node(rangearea)
signal triggered
func attack(unused_var):
	triggered.emit()
	var bodies = rangebox.get_overlapping_bodies()
	for i in bodies:
		if i.is_in_group("player") and damageplayers and i.has_node("HealthComponent"):
			i.get_node("HealthComponent").take_damage(damage)
		if i.is_in_group("enemy") and damageenemies and i.has_node("HealthComponent"):
			i.get_node("HealthComponent").take_damage(damage)
	pass
