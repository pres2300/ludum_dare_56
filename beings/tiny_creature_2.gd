extends "res://beings/enemy_base.gd"

@export var move_speed: int = 300

var direction: Vector2 = Vector2(0,0)

func _ready() -> void:
	var target_point: Vector2 = get_tree().get_first_node_in_group("Player").global_position
	direction = (target_point-global_position).normalized()

func _process(delta: float) -> void:
	global_position += direction*move_speed*delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
