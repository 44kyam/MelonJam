extends Area2D

var hover: bool = false
var fill: bool = false
@export var idx: int

func _mouse_enter():
	hover = true
	
	
func _mouse_exit():
	hover = false
	
func _input(event):
	if hover and event.is_action_pressed("leftMouseClick"):
		# if fill, reset position of the fill node(trigger in beadboxScene)
		# if not fill and root.beadClick = true, bead pos = self pos
		get_node("../..").snap_bead_to_area(self, idx-1, fill)
		
