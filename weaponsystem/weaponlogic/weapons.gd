@abstract 
extends Node2D
class_name Weapon


@export_subgroup("meta")
@export var wpname = ""
@export_subgroup("Primary Attacks")
@export var paction = "weapon_primary"
@export var primary_damage = 10.0
@export var primary_duration = 0.5
@export var primary_cooldown = 0.5


@export_subgroup("Secondary Attacks")
@export var saction = "weapon_secondary"
@export var secondary_damage = 10.0
@export var secondary_duration = 0.5
@export var secondary_cooldown = 0.5


@export_subgroup("Special")
@export var spaction = "weapon_special"
@export var special_damage = 10.0
@export var special_cooldown = 0.5
@export var special_duration = 0.5


var primarytimer = 0.0
var secondarytimer = 0.0
var specialtimer = 0.0

func _process(delta: float) -> void:
	pass
	
	
func handleprimary(delta):
	if primarytimer < primary_cooldown:
		primarytimer += delta
	elif Input.is_action_just_pressed(paction):
		print('primary from weapon')
		primarytimer = 0.0
		_primary(primary_damage, primary_duration)
func handlesecondary(delta):
	if primarytimer < primary_cooldown:
		secondarytimer += delta
		secondarytimer = 0.0
	elif Input.is_action_just_pressed(saction):
		_secondary(primary_damage, primary_duration)
		
func handlespecial(delta):
	if primarytimer < primary_cooldown:
		secondarytimer += delta
	elif Input.is_action_just_pressed(spaction):
		specialtimer = 0.0
		_special(primary_damage, primary_duration)
	

@abstract func _primary(primary_damage, primary_duration)
@abstract func _secondary(primary_damage, primary_duration)
@abstract func _special(primary_damage, primary_duration)

@abstract func hideheld()
@abstract func showheld()
func getname():
	return name
