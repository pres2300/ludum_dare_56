extends CharacterBody2D

@export var move_speed: int = 500

func is_dead() -> bool:
	return false

func get_input() -> Vector2:
	return Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _physics_process(_delta: float) -> void:
	if is_dead():
		return

	var input_direction: Vector2 = get_input()
	velocity = input_direction*move_speed
	move_and_slide()
