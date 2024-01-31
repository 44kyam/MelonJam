extends Area2D
class_name Clickables

@export var tag: String
var hover: bool = false
var click: bool = false

func _input(ev):
	if hover and tag == "regi" and $"../..".pause == false and ev.is_action_pressed("leftMouseClick"):
		$AnimationPlayer.play("regi")

func _mouse_enter():
	hover = true
	if tag == "bell":
		$AnimationPlayer.play("bellRing")
	elif tag == "regi":
		pass
	else:
		$HoverAudio.play()
		$Img.visible = false
		$ImgHover.visible = true
		
		match tag:
			"slide":
				position.x -= 50
			"expand":
				scale.x += 0.05
				scale.y += 0.05
	
func _mouse_exit():
	hover = false
	
	if tag != "bell" and tag != "regi":
		$Img.visible = true
		$ImgHover.visible = false
		
		match tag:
			"slide":
				position.x += 50
			"expand":
				scale.x -= 0.05
				scale.y -= 0.05
