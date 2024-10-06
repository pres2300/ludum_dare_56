extends CharacterBody2D

@export var move_speed: int = 500

func _ready() -> void:
	# Create path

	pass

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
