extends Area2D

@export var move_speed: int = 500

enum EnemyType { SQUID }

var enemy_type: EnemyType

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage()
