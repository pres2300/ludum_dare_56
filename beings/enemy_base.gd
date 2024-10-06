extends Area2D

@export var move_speed: int = 500

enum EnemyType { SQUID }

var enemy_type: EnemyType

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
