extends CharacterBody2D

var hover: bool = false
var click: bool = false
var notClickable: bool = false
var ogPosition
@export var letter: String


# Called when the node enters the scene tree for the first time.
func _ready():
	ogPosition = position

func _mouse_enter():
	if !click:
		scale.x += 0.07
		scale.y += 0.07
	hover = true
	
func _mouse_exit():
	if !click:
		scale.x -= 0.06
		scale.y -= 0.06
	hover = false

func _input(event):
	if hover and event.is_action_pressed("leftMouseClick") and !notClickable:
		if click:
			beadDown()
			get_node("../..").currentBead = null
			get_node("../..").beadClick = false
		else:
			beadUp()
		

func beadDown():
	$sfx.play()
	scale = Vector2(0.5,0.5)
	z_index = 1
	position.y += 30
	click = false

func beadUp():
	$sfx.play()
	scale = Vector2(0.6,0.6)
	z_index = 5
	position.y -= 30
	click = true
	get_node("../..").new_bead_click(self)

func reset():
	scale = Vector2(0.5,0.5)
	z_index = 1
	position = ogPosition
	click = false
	notClickable = false
