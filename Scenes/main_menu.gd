extends Node2D

func startGame():
	get_tree().change_scene_to_file("res://Scenes/level1.tscn")

func _input(ev):
	if $Button/StartButton.hover and ev.is_action_pressed("leftMouseClick"):
		$AnimationPlayer.play("startGame")

