extends Control

@onready var scrollbar = %ScrollContainer.get_v_scroll_bar()
var max_scroll_length = 0 

var client = "The Duke"
var me = "Artisan"
var current = 3 # 1 = me, 2 = client, 3 = empty
var myColor = "[color=#cc6eb0]"
var clientColor= "[color=#e29f58]"

# Called when the node enters the scene tree for the first time.
func _ready():
	scrollbar.changed.connect(handle_scrollbar_changed)

func handle_scrollbar_changed(): 
	if max_scroll_length != scrollbar.max_value: 
		max_scroll_length = scrollbar.max_value 
		%ScrollContainer.scroll_vertical = max_scroll_length

func addToLog(text, num):
	match num:
		1: 
			if current != 1:
				if current != 3: %historyText.text += '[/color]\n'
				current = 1
				%historyText.text += clientColor
				%historyText.text += ("[b]- " + client + " -[/b] \n")
			%historyText.text += text + '\n'
		2:
			if current != 2:
				if current != 3: %historyText.text += '[/color]\n'
				current = 2
				%historyText.text += myColor
				%historyText.text += ("[b]- " + me + " -[/b] \n")
			%historyText.text += text + '\n' 
		3:
			if current != 3:
				current = 3
				%historyText.text += '[/color]\n'
			%historyText.text += ("[center][color=#fff]"+text+"[/color][/center]\n")
	
func clear():
	%historyText.text = myColor + "[b]- Artisan -[/b] \n"


func _on_exit_button_input_event(_viewport, event, _shape_idx):
	if $ExitButton.hover and event.is_action_pressed("leftMouseClick"):
		$"..".uiButtonClose()
