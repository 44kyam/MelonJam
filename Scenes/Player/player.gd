extends CharacterBody2D

@export var speed: int = 500
var mouseIn: bool = false
var new_texture
var old_texture

# Called when the node enters the scene tree for the first time.
func _ready():
	new_texture = preload("res://1.png")
	old_texture = $Sprite2D.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# input
	var direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = direction * speed
	move_and_slide() # auto include delta

func _mouse_enter():
	#print("enter")
	mouseIn = true
	self.scale = Vector2(2,2)
	
	
func _mouse_exit():
	#print("leave")
	mouseIn = false
	self.scale = Vector2(1,1)

func _input(event):
	if mouseIn and event.is_action_pressed("leftMouseClick"):
		if $Sprite2D.texture == new_texture:
			$Sprite2D.texture = old_texture
		else:
			$Sprite2D.texture = new_texture
		
