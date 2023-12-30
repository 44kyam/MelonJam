extends Area2D
class_name Clickables

@export var tag: String
var hover: bool = false
var click: bool = false

func _mouse_enter():
	hover = true
	$Img.visible = false
	$ImgHover.visible = true
	
	match tag:
		"slide":
			position.x -= 50
		"expand":
			scale = Vector2(1.05, 1.05)
	
func _mouse_exit():
	hover = false
	$Img.visible = true
	$ImgHover.visible = false
	
	match tag:
		"slide":
			position.x += 50
		"expand":
			scale = Vector2(1, 1)
