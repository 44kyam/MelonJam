extends Node2D

@onready var pages = $Pages.get_children()
var idx = 0

func reset():
	idx = 0
	$Buttons/BookLeftButton.visible = false
	$Buttons/BookRightButton.visible = true

func _on_book_left_button_input_event(_viewport, event, _shape_idx):
	if $Buttons/BookLeftButton.hover and event.is_action_pressed("leftMouseClick"):
		pages[idx].visible = false
		idx -= 1
		pages[idx].visible = true
		
		if idx == 0:
			$Buttons/BookLeftButton.visible = false
		
		if idx == 2:
			$Buttons/BookRightButton.visible = true


func _on_book_right_button_input_event(_viewport, event, _shape_idx):
	if $Buttons/BookRightButton.hover and event.is_action_pressed("leftMouseClick"):
		pages[idx].visible = false
		idx += 1
		pages[idx].visible = true
		
		if idx == 3:
			$Buttons/BookRightButton.visible = false
		
		if idx == 1:
			$Buttons/BookLeftButton.visible = true


func _on_book_x_button_input_event(_viewport, event, _shape_idx):
	pass # Replace with function body.
