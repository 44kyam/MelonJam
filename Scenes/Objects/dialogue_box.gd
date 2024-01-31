extends Area2D

@export var num:int

var dialogues = [
	"Hey",
	"Heyheyhey!!",
	"adads sbsfdksb sfd eerbfjwebkwebwe efhbefbe"
]

var hover: bool = false

var dialogue_idx = 0
var finish = false

func _mouse_enter():
	hover = true
	#print("hover")
	
func _mouse_exit():
	hover = false

func getText():
	return $RichTextLabel.text

func loadDialogue(dial, stopPause):
	#if dialogue_idx < dialogues.size():
		#print(dial)
		$AnimationPlayer.play("typing")
		$"..".pause = true
		$RichTextLabel.bbcode_text = dial #dialogues[dialogue_idx]
		var dialLen = len(dial)
		var time = 1/(dialLen * 0.02)
		$TypingAnimation.play("typing", -1, time)
		
		finish = true
		
		if stopPause:
			$"..".pause = false
	#else:
		#queue_free()
		
