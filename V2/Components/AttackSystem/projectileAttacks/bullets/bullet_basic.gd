extends StaticBody2D
class_name Basic_Bullet


@export var SPEED: int = 6000
@export var impact_particles: PackedScene
@export var damageplayers: bool
@export var damageenemies: bool
@export var playerinteraction: bool
@export var enemyinteraction: bool
@export var damage = 2.0

var time = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	var tween = get_tree().create_tween()
	tween.tween_property(self, "SPEED", 1000, 0.1)
	tween.tween_property(self, "SPEED", 0, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	time = 0

func setup():
	if !playerinteraction:
		set_collision_mask_value(1, false)
	else:
		set_collision_mask_value(1,true)
	if !enemyinteraction:
		set_collision_mask_value(3, false)
	else:
		set_collision_mask_value(3,true)
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(transform.x * SPEED * delta)
	if collision:
		var body = collision.get_collider()

		spawn_impact(collision.get_position(), collision.get_normal())
		if body.is_in_group("player") and damageplayers and body.has_node("HealthComponent"):
			body.get_node("HealthComponent").take_damage(damage)
		if body.is_in_group("enemy") and damageenemies and body.has_node("HealthComponent"):
			body.get_node("HealthComponent").take_damage(damage)
		# check if colliding with a non collision object
		queue_free()



func attack(e): # shouldn't be called
	pass
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func spawn_impact(pos: Vector2, normal: Vector2):
	var p = impact_particles.instantiate()
	p.global_position = pos
	p.rotation = normal.angle()
	get_tree().current_scene.add_child(p)
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	else:
		queue_free()
	queue_free()
