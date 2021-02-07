extends Node2D

var lvl1 = preload("res://Scenes/Level/Level1.tscn").instance();

onready var lvl_timer = $Timer;

func _ready():
	$ViewportContainer/Viewport.add_child(lvl1);
