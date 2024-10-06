extends CharacterBody2D

@export var move_speed: int = 500
@export var health: int = 5 : set = change_texture

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

signal dead

var little_guy_textures: Dictionary = {
	"green": preload("res://art_assets/little_guy/little_guy1.png"),
	"lime": preload("res://art_assets/little_guy/little_guy2.png"),
	"yellow": preload("res://art_assets/little_guy/little_guy3.png"),
	"orange": preload("res://art_assets/little_guy/little_guy4.png"),
	"red": preload("res://art_assets/little_guy/little_guy5.png"),
}

func is_dead() -> bool:
	return (health <= 0)

func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func change_texture(current_health: int) -> void:
	health = current_health
	match health:
		5:
			sprite.texture = little_guy_textures["green"]
			collision_shape.shape.radius = 10
		4:
			sprite.texture = little_guy_textures["lime"]
			collision_shape.shape.radius = 8
		3:
			sprite.texture = little_guy_textures["yellow"]
			collision_shape.shape.radius = 6
		2:
			sprite.texture = little_guy_textures["orange"]
			collision_shape.shape.radius = 4
		1:
			sprite.texture = little_guy_textures["red"]
			collision_shape.shape.radius = 2
		0:
			# Game over
			dead.emit()

func take_damage() -> void:
	health -= 1

func _physics_process(_delta: float) -> void:
	if is_dead():
		return

	var input_direction: Vector2 = get_input()
	velocity = input_direction*move_speed
	move_and_slide()
