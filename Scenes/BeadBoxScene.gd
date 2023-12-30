extends Node2D

signal toMainCamera
signal toBookCamera

var inTutorial = false
var pause = false

var beadClick: bool = false
var currentBead = null # hold current click bead
var beadObj = {} # holds all beads in the scene
var beadClone = {
	"a" : preload("res://Scenes/Objects/beads/bead_a.tscn"),
	"b" : preload("res://Scenes/Objects/beads/bead_b.tscn"),
	"c" : preload("res://Scenes/Objects/beads/bead_c.tscn"),
	"d" : preload("res://Scenes/Objects/beads/bead_d.tscn"),
	"e" : preload("res://Scenes/Objects/beads/bead_e.tscn"),
	"f" : preload("res://Scenes/Objects/beads/bead_f.tscn"),
	"g" : preload("res://Scenes/Objects/beads/bead_g.tscn"),
	"h" : preload("res://Scenes/Objects/beads/bead_h.tscn"),
	"i" : preload("res://Scenes/Objects/beads/bead_i.tscn"),
	"j" : preload("res://Scenes/Objects/beads/bead_j.tscn"),
}
var playerAnswer = "00000" #holds player's current answer choice
var answer = ""
var ansArr = [null,null,null,null,null]

# Called when the node enters the scene tree for the first time.
func _ready():
	var beadArr = $BeadBoxRoot.get_children()
	for bead in beadArr:
		if "letter" in bead:
			beadObj[bead.letter] = bead
	
	#print(beadObj)

# when a new bead is click
func new_bead_click(bead):
	if currentBead == bead:
		beadClick = false
		# print("same bead")
	else:
		if currentBead != null:
			currentBead.beadDown()
			#print(currentBead)
			
		currentBead = bead
		beadClick = true
		
# trigger when area is click
func snap_bead_to_area(area,idx,fill):
	if !pause:
		var same = ansArr[idx] and beadClick and ansArr[idx].name == currentBead.name
		
		if same:
			$Audio/Bead.play()
		else:
			$Audio/Bead.play()
		
		if fill:
			ansArr[idx].queue_free()
			ansArr[idx] = null
			playerAnswer[idx] = "0"
			area.fill = false
		
		# if a bead is up
		if currentBead and beadClick and not same:
			playerAnswer[idx] = currentBead.letter
			var dup = beadClone[currentBead.letter].instantiate()
			$BeadSnap.add_child(dup)
			dup.position = area.position
			dup.notClickable = true
			dup.scale = currentBead.scale
			ansArr[idx] = dup
			area.fill = true
	
		#print(playerAnswer)
	

# reset button click function
func _on_reset_button_input_event(_viewport, event, _shape_idx):
	if $UI/ResetButton.hover and event.is_action_pressed("leftMouseClick"):
		$Audio/Reset.play()
		
		resetAll()

# reset the board
func resetAll():
	playerAnswer = "00000"
	beadClick = false
	currentBead = null
	for key in beadObj:
		beadObj[key].reset()
	
	var areaArr = $BeadSnapPos.get_children()
	for a in areaArr:
		a.fill = false
		
	for i in range(5):
		if ansArr[i]:
			ansArr[i].queue_free()
		ansArr[i] = null

# validate button click
func _on_validate_button_input_event(_viewport, event, _shape_idx):
	if $UI/ValidateButton.hover and event.is_action_pressed("leftMouseClick"):
		validate()

func validate():
	var answerArr = answer.split(" ")
	
	if playerAnswer in answerArr:
		#print("correct")
		$Audio/Correct.play()
		if inTutorial:
			runTutorial()
		else:
			toMainCamera.emit("correct")
	else:
		$Audio/Wrong.play()

# book button click
func _on_book_button_input_event(_viewport, event, _shape_idx):
	if $UI/BookButton.hover and event.is_action_pressed("leftMouseClick"):
		$Audio/Click.play()
		toBookCamera.emit(1)
	

# exit button click
func _on_exit_button_input_event(_viewport, event, _shape_idx):
	if $UI/ExitButton.hover and event.is_action_pressed("leftMouseClick"):
		if !inTutorial:
			$Audio/Click.play()
			toMainCamera.emit("")
		else:
			$Audio/Wrong.play()

# play tutorial

var tutorial = [
	#[PULL HELP SCREEN UP. FORCED TUTORIAL TIME]
	["Alright! I think I still remember the charms from the books I've studied.", 1],
	["From what I remember, the bead that goes in the centre should be the subject.", 1],
	["So... the main focus is of my wish.", 1],
	["In this case, it’ll be for well-being and happiness...", 1],
	["Which means it’ll be the green bead!", 1],
	["As for the ones sandwiching it, it’ll be the beads for drawing in or repelling certain energies.", 1],
	["I’m wishing for a lot of positivity and happiness, so I’m gonna grab the yellow bead.", 1],
	["This should be symmetrical for a clear and concise charms.", 1],
	["So one yellow on each side!", 1],
	["Quoting my mentor - Asymmetrical charms are for greedy people who have more than one wish.", 1],
	["I’ll save that for my clients.", 1],
	["Finally, the teal beads on the emphasis spots for the medium boost.", 1],
	["I’m not going to use up all my luck immediately, not on my first day!", 1],
	["So the charm should be - teal, yellow, green, yellow, teal.", 1],
	["Let me write this down!", 1],
	[null, 3],
	["There we go!", 1],
	["Hopefully this charm will make sure things go smoothly for me.", 1],
	["With this… I think I’m ready to open for business.", 1],
	["...!", 1],
	["I think I hear someone already.", 1],
	["Coming…!", 1],
	[null, 2]
	]
var tutorialIdx = 0


var box2 = preload("res://Scenes/Objects/dialogue_box2.tscn")
var box = null

func runTutorial():
	inTutorial = true
	pause = true
	
	
	if tutorialIdx < len(tutorial):
		yeetBox()
		
		var lineArr = tutorial[tutorialIdx]
		var i = lineArr[1] # box index
		var line = lineArr[0] # text
		match i:
				
			1: 
				box = box2.instantiate()
	
			2: 
				pause = false
				inTutorial = false
				toMainCamera.emit("start")
			
			3: 
				pause = false
				$UI.openTutorialPage()
		
		# if box is not null
		if box != null:
			add_child(box)
			box.position = $DialogueBox2.position
			box.loadDialogue(line, false)
		
		tutorialIdx += 1

		
		
		

func yeetBox():
	if box:
		box.queue_free()
		box = null
	

func _input(ev):
	if inTutorial and ev.is_action_pressed("leftMouseClick") and box != null and box.hover:
		runTutorial()
