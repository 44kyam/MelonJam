extends Node2D

signal toMainCamera
signal toBeadBox

@onready var pages = $Pages.get_children()
var idx = 0
var exit = 0 # 0 = middle scene, 1 = beadBox scene

func reset():
	idx = 0
	for p in pages:
		p.visible = false
		
	$Pages/p1.visible = true
		
	$Buttons/BookLeftButton.visible = false
	$Buttons/BookRightButton.visible = true

func _on_book_left_button_input_event(_viewport, event, _shape_idx):
	if $Buttons/BookLeftButton.hover and event.is_action_pressed("leftMouseClick"):
		$page.play()
		pages[idx].visible = false
		idx -= 1
		pages[idx].visible = true
		
		if idx == 0:
			$Buttons/BookLeftButton.visible = false
		
		if idx == 2:
			$Buttons/BookRightButton.visible = true


func _on_book_right_button_input_event(_viewport, event, _shape_idx):
	if $Buttons/BookRightButton.hover and event.is_action_pressed("leftMouseClick"):
		$page.play()
		pages[idx].visible = false
		idx += 1
		pages[idx].visible = true
		
		if idx == 3:
			$Buttons/BookRightButton.visible = false
		
		if idx == 1:
			$Buttons/BookLeftButton.visible = true


func _on_book_x_button_input_event(_viewport, event, _shape_idx):
	if $Buttons/BookXButton.hover and event.is_action_pressed("leftMouseClick"):
		$page.play()
		if exit == 0:
			toMainCamera.emit()
		else:
			toBeadBox.emit()
