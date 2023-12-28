extends Area2D
class_name Clickables

var hover: bool = false

func _mouse_enter():
	hover = true
	
func _mouse_exit():
	hover = false
