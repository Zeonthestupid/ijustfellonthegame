extends base_attack


@export_enum ("patterned", "one-shot") var type: String
@export var attacks := 1
@export var attack_rotation := 0
@export var bullet: Resource
@export var marker: Marker2D
@export_subgroup("pattern config")
@export var angles: Array[float] = []
@export var delay: Array[float] = []
@export_subgroup("one-shot config")


func _process(delta: float) -> void:
	pass

func attack(attackvector: Vector2):
	if type == "patterned":
		for i in angles:
			attackvector = attackvector.normalized()
			var angle = deg_to_rad(i) + attackvector.angle()
			var bullet_instance = bullet.instantiate()
			bullet_instance.setup()
			bullet_instance.damage = damage
			bullet_instance.rotation = angle
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = marker.global_position
			
	if type == "one-shot":
		attackvector = attackvector.normalized()
		var bullet_instance = bullet.instantiate()
		bullet_instance.setup()
		bullet_instance.damage = damage
		get_tree().root.add_child(bullet_instance)
		bullet_instance.global_position = marker.global_position
		bullet_instance.rotation = attackvector.angle()
