extends RigidBody2D
@export var damage := 10.0
@export var knockback := 10.0

@export var SPEED: int = 3000
@export var impact_particles: PackedScene
var time = 0

func _ready() -> void:
	time = 0
	pass # Replace with function body.



func _physics_process(delta: float) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "SPEED", 1000, 0.1)
	tween.tween_property(self, "SPEED", 0, 0.25).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	var collision = move_and_collide(transform.x * SPEED * delta)
	if collision:
		spawn_impact(collision.get_position(), collision.get_normal())
		var body = collision.get_collider()
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()


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
