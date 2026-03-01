extends Weapon

const BULLET = preload("res://weaponsystem/weapons/harpoon_gun/hpblt.tscn")
@export var kbfactor = 1000
@export var tweenin = 0.1
@export var tweenout = 0.5
signal harpoon_shot(rotation)
# Called when the node enters the scene tree for the first time.
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	pass # Replace with function body.
var time = 0.0
var kbpower = 0.0
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
	var shotdist = Vector2.ZERO
	var bullet_instance = BULLET.instantiate()
	get_tree().root.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.rotation = rotation
	emit_signal("harpoon_shot", rotation_degrees)
	var x = Vector2(-cos((get_global_mouse_position() - global_position).angle())*kbfactor, -sin((get_global_mouse_position() - global_position).angle())*kbfactor)
	get_parent().apply_knockback(x, tweenin, tweenout)
func _secondary(pw, cd):
	pass

func _special(pw, cd):
	pass
	pass
func hideheld():
	if sprite_2d:
		sprite_2d.hide()
		print("hidden")
	else:
		print("nothiddencausenosprite")
	pass
func showheld():
	if sprite_2d:
		sprite_2d.show()
		print("hidden")
	else:
		print("nothiddencausenosprite")
	pass
