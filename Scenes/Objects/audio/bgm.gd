extends Node

func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()

func deleteAudio():
	queue_free()

func playDrawerAudio():
	$drawer.play()

func playPageAudio():
	$page.play()

func playHoverAudio():
	$hover.play()
