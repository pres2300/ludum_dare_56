extends Control

@onready var paused: Label = $MarginContainer2/Paused
@onready var start: Label = $MarginContainer3/Start
@onready var game_over: Label = $MarginContainer3/GameOver
@onready var score: Label = $MarginContainer/Score

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused:
			paused.show()
		else:
			paused.hide()
