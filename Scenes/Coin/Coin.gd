extends Node2D

var coin_point : int = 1;

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		body.coin_update(body.coinDB.add_coin(coin_point));
		queue_free();
