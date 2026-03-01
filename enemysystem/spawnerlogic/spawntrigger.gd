extends Area2D

@export var waves: Array[SpawnWave]
@export var delay_between_waves := 3.0

var active := false
var current_wave := 0
func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if active:
		return
	if body.name == "player":
		active = true
		start_waves()
		

func start_waves():
	while current_wave < waves.size():
		print("spawning" + str(current_wave))
		await spawn_wave(waves[current_wave])
		await wait_for_clear()
		current_wave += 1
		await get_tree().create_timer(delay_between_waves).timeout


func wait_for_clear():
	while get_tree().get_nodes_in_group("enemies").size() > 0:
		await get_tree().process_frame


func spawn_wave(wave: SpawnWave):
	for i in wave.enemy_count:
		get_tree().call_group(
			"enemy_spawner",
			"spawn_group",
			wave.spawn_group
		)
		await get_tree().create_timer(wave.delay_between_spawns).timeout
