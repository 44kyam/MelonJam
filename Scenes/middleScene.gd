extends Node2D

signal toBeadBoxCamera

var pause = false

var box1 = preload("res://Scenes/Objects/dialogue_box.tscn")
var box2 = preload("res://Scenes/Objects/dialogue_box.tscn")
var box = null

var x = 1
var level = 0
var dialogues = [
	["This is a dialogue", 0], 
	["Dislogue", 1],
	[null, 2]
	]
var thanks = [
	["Wow! Thanks!", 0]
	]
var idx = 0
var thanksIdx = 0

var answers = ["aaaaa"]
var db = [] #dialogue box
var db_idx = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	db = [$DialogueBox, $DialogueBox2]

func _input(event):
	if event.is_action_pressed("Up"):
		x += 1
		print(x)
		
	if event.is_action_pressed("Right"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(550, -2), 1)
	
	if event.is_action_pressed("Left"):
		var tween = create_tween()
		tween.tween_property($Camera2D, "position", Vector2(-550, -2), 1)
	
	if event.is_action_pressed("Down"):
		dialRun()
	
	if event.is_action_pressed("leftMouseClick"):
		if db_idx < 2 and box.finish and box.hover:
			idx += 1
			dialRun()
		
		#if db_idx < 2 and db[db_idx].finish and db[db_idx].hover:
			#idx += 1
			#db[db_idx].visible = false
			#db[db_idx].finish = false
			#dialRun()

func _on_color_rect_gui_input(event):
	if event.is_action_pressed("leftMouseClick"):
		toBeadBoxScene()
		print("Click")

func toBeadBoxScene():
	if !pause:
		toBeadBoxCamera.emit(answers[level])

func dialRun():
	yeetBox()
	
	if idx < len(dialogues) and dialogues[idx][1] < 2:
		print("in")
		db_idx = dialogues[idx][1]
		
		if db_idx == 0:
			box = box1.instantiate()
		else:
			box = box2.instantiate()
		add_child(box)
		box.position = db[db_idx].position
			
		#db[db_idx].visible = true
		box.loadDialogue(dialogues[idx][0], false)
	else:
		db_idx = 2
		pause = false

func TYDialRun():
	yeetBox()
	
	if thanksIdx < len(thanks):
		db_idx = thanks[thanksIdx][1]
		
		if db_idx == 0:
			box = box1.instantiate()
		else:
			box = box2.instantiate()
		add_child(box)
		box.position = db[thanksIdx].position
		
		box.loadDialogue(thanks[thanksIdx][0], true)
		thanksIdx += 1
	
func yeetBox():
	if box:
		box.queue_free()
		box = null
