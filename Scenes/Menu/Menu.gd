extends Node2D


func _on_Play_pressed():
	get_tree().change_scene("res://Scenes/Level/LevelContainer.tscn");

func focus():
	$Control/VBoxContainer2/HBoxContainer/VBoxContainer/Play.grab_focus();
