extends Area2D

var dialogues = [
	"Hey",
	"Heyheyhey!!",
	"adads sbsfdksb sfd eerbfjwebkwebwe efhbefbe"
]

var hover: bool = false

var dialogue_idx = 0
var finish = false

func _ready():
	$RichTextLabel.visible_characters = 0
	#loadDialogue("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", false)

func _mouse_enter():
	hover = true
	#print("hover")
	
func _mouse_exit():
	hover = false

func loadDialogue(dial, stopPause):
	#if dialogue_idx < dialogues.size():
		#print(dial)
		$AnimationPlayer.play("typing")
		$"..".pause = true
		$RichTextLabel.bbcode_text = dial #dialogues[dialogue_idx]
		var dialLen = $RichTextLabel.text.length()
		var typeChars = dialLen - $RichTextLabel.visible_characters
		var time = typeChars * 0.02
		var tween = create_tween()
		tween.tween_property($RichTextLabel, "visible_characters", dialLen, time)
		await tween.finished
		
		finish = true
		
		if stopPause:
			$"..".pause = false
	#else:
		#queue_free()
		
