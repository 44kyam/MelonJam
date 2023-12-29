extends Area2D
class_name Clickables

var hover: bool = false
var click: bool = false

func _mouse_enter():
	hover = true
	$Img.visible = false
	$ImgHover.visible = true
	
func _mouse_exit():
	hover = false
	$Img.visible = true
	$ImgHover.visible = false
