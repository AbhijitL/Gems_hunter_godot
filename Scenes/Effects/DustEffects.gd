extends Node2D

var motion : Vector2 = Vector2(rand_range(-10,10),rand_range(-5,-20));

func _process(delta):
	position += motion * delta;
