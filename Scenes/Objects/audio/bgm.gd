extends Node


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()

func deleteAudio():
	queue_free()
