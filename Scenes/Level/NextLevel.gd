extends Node2D




func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene("res://Scenes/Level/Lvl1/LvlCont1.tscn");
