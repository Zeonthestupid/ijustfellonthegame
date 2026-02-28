extends Node2D


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
		

	# Get hold time, release with a large hold velocity and deaccelerate every frame.
	# Check wall colision, and then if it's been colided, bring player to it, else bring it to player.
	
	if Input.is_action_just_pressed("weapon_primary"):
		time = delta
	var charge = min(1.3 - (1.3 - time), 1.3)
	
	
	if Input.is_action_just_released("weapon_primary"):
		pass
	print(charge)
	
	
	
	
#func shoot(charge):
	#var bullet_instance = BULLET.instantiate()
	#bullet_instance.setup(charge)
	#get_tree().root.add_child(bullet_instance)
	#bullet_instance.global_position = muzzle.global_position
	#bullet_instance.rotation = rotation
	#emit_signal("harpoon_shot", rotation_degrees)
