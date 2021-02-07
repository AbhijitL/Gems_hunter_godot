extends Node2D

var lvl0 = preload("res://Scenes/Level/Level0.tscn").instance();

onready var lvl_timer = $Timer;

func _ready():
	$ViewportContainer/Viewport.add_child(lvl0);


