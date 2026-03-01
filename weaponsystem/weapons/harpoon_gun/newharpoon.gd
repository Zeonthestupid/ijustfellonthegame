extends Weapon

const BULLET = preload("res://weaponsystem/weapons/harpoon_gun/hpblt.tscn")

signal harpoon_shot(rotation)
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	pass # Replace with function body.
var time = 0.0
@onready var muzzle: Marker2D = $Marker2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float)-> void:
	time += delta
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	
func _primary(pw, cd):
	print('primary from gun')
	var shotdist = Vector2.ZERO
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	emit_signal("harpoon_shot", rotation_degrees)
func _secondary(pw, cd):
	pass

func _special(pw, cd):
	pass
	
