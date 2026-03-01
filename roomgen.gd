extends Node2D

const SPAWN_ROOMS: Array[PackedScene] = [preload("res://roomas/room4.tscn")]
const Middle_Rooms: Array= [preload("res://roomas/room1.tscn"), 
preload("res://roomas/room2.tscn"), preload("res://roomas/room3.tscn")]
const End_Rooms: Array= [preload("res://roomas/room5.tscn")]
const Tile_Size:int =  32
const Wall_Tile:int = 2

@export var num_levels:int = 5
var roomb
@onready var player: CharacterBody2D = get_parent().get_node("player")

func _ready():
	_spawn_rooms()



func _spawn_rooms():
	var previous_room: Node2D
	
	for i in num_levels:
		var roomspawn: Node2D
		
		if i == 0:
			roomb = SPAWN_ROOMS[(randi() % SPAWN_ROOMS.size())-1]
			roomspawn = roomb.instantiate()
			roomspawn.global_position = player.global_position
			
		add_child(roomspawn)
		previous_room=roomspawn
		
