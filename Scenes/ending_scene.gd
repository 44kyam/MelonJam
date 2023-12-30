extends Node2D


func ending():
	var bgm = get_node("/root/Bgm")
	bgm.deleteAudio()
