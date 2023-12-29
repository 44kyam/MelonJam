extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$MiddleScene/Camera2D.make_current()

# to bead box scene
func _on_middle_scene_to_bead_box_camera(ans):
	$MiddleScene.process_mode = PROCESS_MODE_DISABLED
	$BeadBoxScene.resetAll()
	$BeadBoxScene.answer = ans
	
	$BeadBoxScene.position = Vector2($MiddleScene/Camera2D.position.x, -2000)
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($BeadBoxScene, "position:y", 50, 0.5)
	tween.tween_property($MiddleScene, "modulate", Color(0,0,0), 0.5)
	await tween.finished
	$BeadBoxScene.position = Vector2(-31, 1329)
	
	$BeadBoxScene/Camera2D.make_current()

# to middle scene
func _on_bead_box_scene_to_main_camera(note):
	$MiddleScene.process_mode = PROCESS_MODE_INHERIT
	
	if note == "correct":
		$MiddleScene/Camera2D.position = Vector2(-2,2)
	
	$MiddleScene/Camera2D.make_current()
	$BeadBoxScene.position.y = 0
	$BeadBoxScene.position.x = $MiddleScene/Camera2D.position.x
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property($BeadBoxScene, "position:y", -2000, 0.5)
	tween.tween_property($MiddleScene, "modulate", $BeadBoxScene.modulate, 0.4)
	await tween.finished
	
	if note == "correct":
		$MiddleScene.TYDialRun()
		
	$BeadBoxScene.position = Vector2(-31, 1329)
	
	
