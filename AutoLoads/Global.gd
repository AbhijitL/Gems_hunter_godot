extends Node2D


var global_coin : int = 0;
var dead : int = 0;
var levels_data : Array = [];

func _update_global_coin(amnt:int):
	if amnt == 0:
		global_coin = 0;
	else:
		global_coin += amnt;

func get_global_coin():
	return global_coin;
	
func _update_death_count(amnt:int):
	dead += amnt;

func get_death_count():
	return dead;
