extends Area2D

@onready var bgm: Node = get_node("/root/Bgm")

@export var tag: String
var hover: bool = false
var out: bool = false
var outPos: Vector2 = Vector2(0,0)
var notOutPos: Vector2 = Vector2(100,850)
			
func _mouse_enter():
	hover = true
	if !out:
		image1Visible(true)
		bgm.playHoverAudio()

func _mouse_exit():
	hover = false
	if !out:
		image1Visible(false)

func _input(event):
	if out and event.is_action_pressed("leftMouseClick"):
		bgm.playPageAudio()
		image1Visible(false)
		position = notOutPos
		out = false
		%HelpButton.visible = true
		%HistoryButton.visible = true
		$"../SolidColor".visible = false

	elif !out and hover and event.is_action_pressed("leftMouseClick"):
		bgm.playPageAudio()
		image1Visible(true)
		position = outPos
		out = true
		%HelpButton.visible = false
		%HistoryButton.visible = false
		$"../SolidColor".visible = true
		

# true = image1 is visible
# false = image2 is visible 
func image1Visible(image1):
	$image.visible = image1
	$image2.visible = !image1
