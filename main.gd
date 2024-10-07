extends Node

@export var enemy1: PackedScene = null
@export var enemy2: PackedScene = null
@export var starting_spawn_interval: float = 2.0
@export var spawn_interval: float = 2.0
@export var difficulty_modifier: int = 0
@export var difficulty_interval: int = 10

@onready var enemy1_timer: Timer = $Enemy1SpawnTimer
@onready var enemy2_timer: Timer = $Enemy2SpawnTimer
@onready var game_timer: Timer = $GameTimer
@onready var hud: Control = $CanvasLayer/HUD
@onready var player: CharacterBody2D = $Player

var game_time: int = 0
var game_running: bool = false
var screensize: Vector2 = Vector2(640.0, 360.0)

func start_game() -> void:
	game_time = 0
	difficulty_modifier = 0
	hud.score.text = str(game_time)
	player.revive()
	game_running = true
	hud.start.hide()
	hud.game_over.hide()
	game_timer.start()
	spawn_interval = starting_spawn_interval
	enemy1_timer.wait_time = spawn_interval
	enemy2_timer.wait_time = spawn_interval
	enemy1_timer.start()
	enemy2_timer.start()

func _ready() -> void:
	# Center the player
	var center: Vector2 = screensize/2
	$Player.position = center

	enemy1_timer.wait_time = spawn_interval
	enemy1_timer.one_shot = false

	player.dead.connect(_player_dead)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and not game_running:
		start_game()

func _player_dead() -> void:
	game_running = false
	game_timer.stop()
	enemy1_timer.stop()
	enemy2_timer.stop()
	hud.game_over.show()

func _on_game_timer_timeout() -> void:
	game_time += 1
	hud.score.text = str(game_time)
	if game_time % difficulty_interval == 0:
		difficulty_modifier += 1
		if spawn_interval > 0.10:
			spawn_interval = spawn_interval-(float(difficulty_modifier)*0.10)
			enemy1_timer.wait_time = spawn_interval
			enemy2_timer.wait_time = spawn_interval

func _on_enemy_1_spawn_timer_timeout() -> void:
	var enemy_instance: Path2D = enemy1.instantiate()
	enemy_instance.position = Vector2(randf_range(0.0, screensize.x), 0)
	enemy_instance.difficulty_modifier = difficulty_modifier
	add_child(enemy_instance)

func _on_enemy_2_spawn_timer_timeout() -> void:
	var enemy_instance: Area2D = enemy2.instantiate()
	enemy_instance.position = Vector2(randf_range(0.0, screensize.x), 0)
	enemy_instance.difficulty_modifier = difficulty_modifier
	add_child(enemy_instance)
