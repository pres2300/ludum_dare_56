extends Node

func _ready() -> void:
	# Center the player
	var center: Vector2 = get_viewport().get_visible_rect().size/2
	$Player.position = center
