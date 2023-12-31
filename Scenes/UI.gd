extends Node2D

var pages
var pageIdx = 0
var UIs
var helpOpen = false

var tutorialPage = false

func _ready():
	pages = $HelpPages.get_children()
	UIs = get_children()
	#print(UIs)

func _input(ev):
	# tutorial page is open
	if tutorialPage and ev.is_action_pressed("leftMouseClick"):
		uiButtonClose()
		tutorialPage = false
		$Audio/Page.play()
		$tutorialPage.queue_free()
	
	# next help pages
	if helpOpen and ev.is_action_pressed("leftMouseClick"):
		$Audio/Page.play()
		if pageIdx < len(pages)-1:
			pages[pageIdx].visible = false
			pageIdx += 1
			pages[pageIdx].visible = true
		else:
			helpOpen = false
			pages[pageIdx].visible = false
			pageIdx = 0
			pages[pageIdx].visible = true
			uiButtonClose()
			
# tutorial page
func openTutorialPage():
	$Audio/Page.play()
	uiButtonOpen()
	tutorialPage = true
	$tutorialPage.visible = true

# help button click
func _on_help_button_input_event(_viewport, event, _shape_idx):
	if %HelpButton.hover and event.is_action_pressed("leftMouseClick"):
		$Audio/click.play()
		helpButtonOpen(false)

func helpButtonOpen(tutorial):
	uiButtonOpen()
	helpOpen = true
	$HelpPages.visible = true

func uiButtonOpen():
	position = $"../Camera2D".position
	%HelpButton.visible = false
	UIs = get_children()
	for ui in UIs:
		ui.visible = false
		
	$"../..".pauseForUi()
	

func uiButtonClose():
	%HelpButton.visible = true
	for ui in UIs:
		ui.visible = true
		
	$HelpPages.visible = false
	$"../..".unPauseForUi()
	
