extends Node2D


const Spawn_Rooms: Array= [preload("res://roomas/room4.tscn")]
const Middle_Rooms: Array= [preload("res://roomas/room1.tscn"), 
preload("res://roomas/room2.tscn"), preload("res://roomas/room3.tscn")]
const End_Rooms: Array= [preload("res://roomas/room5.tscn")]

const Tile_Size:int =  32
const Wall_Tile:int = 2

@export var num_levels:int = 3

@onready var player: CharacterBody2D = get_parent().get_node("player")

func _ready():
	_spawn_rooms()
	
func _spawn_rooms():
	var previous_room: Node2D
	
	for i in num_levels:
		var room: Node2D
		
		if i == 0:
			room = Spawn_Rooms[randi() % Spawn_Rooms.size()].instance()
			player.position = room.get_node("playerspawn")
		
		add_child(room)
		previous_room=room
		
