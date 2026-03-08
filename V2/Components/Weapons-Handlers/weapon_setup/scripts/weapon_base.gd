extends Node2D

class_name Weapon
@export var weapon_name = ""
@export_subgroup("primary")
@export var p_attack: base_attack
@export var p_action : String
@export var p_cooldown = 0.0
@export_subgroup("secondary")
@export var s_attack: base_attack
@export var s_action : String
@export var s_cooldown = 0.0
@export_subgroup("tertiary")
@export var t_attack: base_attack
@export var t_action : String
@export var t_cooldown = 0.0
var p_active = 0
var s_active = 0
var t_active = 0
func _ready() -> void:
	if !p_action:
		p_action = "weapon_primary"
	if !s_action:
		s_action = "weapon_secondary"
	if !t_action:
		t_action = "weapon_special"

func primary(delta):
	if p_attack:
		if p_active == 0:
			print("attacking")
			p_attack.attack(get_global_mouse_position())
			p_active = p_cooldown
func secondary(delta):
	if s_attack:
		
		if s_active == 0:
			s_attack.attack(get_global_mouse_position())
			s_active = s_cooldown
		
func tertiary(delta):
	if t_attack:
		if t_active == 0:
			t_attack.attack(get_global_mouse_position())
			t_active = t_cooldown
	
	
func handle(delta):
	p_active = max(p_active - delta, 0)
	s_active = max(s_active - delta, 0)
	t_active = max(p_active - delta, 0)
	if Input.is_action_just_pressed(p_action):
		print("weapon in base triggered")
		primary(delta)
	if Input.is_action_just_pressed(s_action):
		secondary(delta)
	if Input.is_action_just_pressed(t_action):
		tertiary(delta)
