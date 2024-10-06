extends Node

@export var enemy: PackedScene = null
@export var starting_spawn_time: float = 2.0

@onready var timer: Timer = $EnemySpawnTimer

var game_time: int = 0

func _ready() -> void:
	# Center the player
	var center: Vector2 = get_viewport().get_visible_rect().size/2
	$Player.position = center

	timer.wait_time = starting_spawn_time
	timer.one_shot = false
	timer.start()

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_instance: Path2D = enemy.instantiate()
	var screensize: Vector2 = get_viewport().size
	print(screensize)
	enemy_instance.position = Vector2(randf_range(0.0, screensize.x), 0)
	add_child(enemy_instance)

func _on_game_timer_timeout() -> void:
	game_time += 1
