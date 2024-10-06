extends Node

@export var enemy: PackedScene = null
@export var starting_spawn_time: float = 2.0

@onready var enemy_timer: Timer = $EnemySpawnTimer
@onready var game_timer: Timer = $GameTimer
@onready var hud: Control = $CanvasLayer/HUD
@onready var player: CharacterBody2D = $Player

var game_time: int = 0
var game_running: bool = false

func start_game() -> void:
	game_time = 0
	hud.score.text = str(game_time)
	player.revive()
	game_running = true
	hud.start.hide()
	hud.game_over.hide()
	game_timer.start()
	enemy_timer.start()

func _ready() -> void:
	# Center the player
	var center: Vector2 = get_viewport().get_visible_rect().size/2
	$Player.position = center

	enemy_timer.wait_time = starting_spawn_time
	enemy_timer.one_shot = false

	player.dead.connect(_player_dead)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not game_running:
		start_game()

func _player_dead() -> void:
	game_running = false
	game_timer.stop()
	enemy_timer.stop()
	hud.game_over.show()

func _on_enemy_spawn_timer_timeout() -> void:
	var enemy_instance: Path2D = enemy.instantiate()
	var screensize: Vector2 = get_viewport().size
	enemy_instance.position = Vector2(randf_range(0.0, screensize.x), 0)
	add_child(enemy_instance)

func _on_game_timer_timeout() -> void:
	game_time += 1
	hud.score.text = str(game_time)
