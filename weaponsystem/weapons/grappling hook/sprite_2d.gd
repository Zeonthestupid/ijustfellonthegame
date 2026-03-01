extends Weapon
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var distance: float = 150

signal hooked(hooked_position)

func interpolate(length, duration = 0.2) : 
	var tween_offset = get_tree().create_tween()
	var tween_rect_h = get_tree().create_tween()
	
	tween_offset. tween_property(self, "offset",Vector2(0,length/2.0),duration)
	tween_rect_h. tween_property(self, "region_rect", Rect2(0,0,16,length),duration)
	
		
		

func reverse_interpolate(x):
	interpolate(0, x)

func cc2():
	var collision_point
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point()
		distance = (global_position - collision_point).length()
		
		hooked.emit(collision_point)
		
		
	else:
		distance = 150
	return distance
func check_collision():
	await get_tree().create_timer(0.1).timeout
	var collision_point
	if ray_cast_2d.is_colliding():
		collision_point = ray_cast_2d.get_collision_point()
		distance = (global_position - collision_point).length()	
		hooked.emit(collision_point)
		
		
		
	else:
		distance = 150
	return distance
func _primary(v, w):
	get_parent().look_at(get_global_mouse_position())
	interpolate(await check_collision(), 0.02)
	var dist = cc2()
	dist = dist * 0.01
	await get_tree().create_timer(0.05).timeout
	reverse_interpolate(0.2*dist)
func _secondary(v,w):
	pass
func _special(v,w):
	pass
