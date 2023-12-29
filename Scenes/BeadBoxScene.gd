extends Node2D

signal toMainCamera

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
	var same = ansArr[idx] and beadClick and ansArr[idx].name == currentBead.name
		
	
	print(same)
	
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
	
		print(playerAnswer)
	

# reset button click function
func _on_reset_button_input_event(_viewport, event, _shape_idx):
	if $UI/ResetButton.hover and event.is_action_pressed("leftMouseClick"):
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
	if playerAnswer == answer:
		print("correct")
		toMainCamera.emit("correct")

# book button click
func _on_book_button_input_event(_viewport, event, _shape_idx):
	pass # Replace with function body.
	

# exit button click
func _on_exit_button_input_event(_viewport, event, _shape_idx):
	if $UI/ExitButton.hover and event.is_action_pressed("leftMouseClick"):
		toMainCamera.emit("")
	
