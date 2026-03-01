extends Node2D

@export var weapons: Array[Weapon]
var skey = ""
var pkey = ""
var spkey = ""
var currentweapon = 0

signal knockback(kb: float, tm: float) 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	add_to_group("weapon_handler")
	init()

func increase():
	currentweapon = (currentweapon+1) % weapons.size()
	init()
func decrease():
	currentweapon = (currentweapon-1) % weapons.size()
	init()

	
func init():
	pkey = weapons[currentweapon].paction
	skey = weapons[currentweapon].saction
	spkey = weapons[currentweapon].spaction
	hideitems()
	weapons[currentweapon].showheld()

func hideitems():
	for i in range(weapons.size()):
		weapons[i].hideheld()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	
	weapons[currentweapon].handleprimary(delta)
	weapons[currentweapon].handlesecondary(delta)
	weapons[currentweapon].handlespecial(delta)
	
	if Input.is_action_just_pressed("w1"):
		currentweapon = 0
		init()
	if Input.is_action_just_pressed("w2"):
		currentweapon = min(1, weapons.size()-1)
		init()
	if Input.is_action_just_pressed("w3"):
		currentweapon = min(2, weapons.size()-1)
		init()
	if Input.is_action_just_pressed("w4"):
		currentweapon = min(3, weapons.size()-1)
		init()
	if Input.is_action_just_pressed("w5"):
		currentweapon = min(4, weapons.size()-1)
		init()
	if Input.is_action_just_pressed("increase_weapon"):
		increase()
	if Input.is_action_just_pressed("decrease_weapon"):
		decrease()
		
func sendknockback(kb, kbtime):
	knockback.emit(kb, kbtime)
