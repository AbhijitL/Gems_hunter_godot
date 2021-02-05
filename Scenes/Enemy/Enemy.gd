extends Node2D
class_name Enemy
var damage_points : int = 1;

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		if !body.healthDB.health == 0:
			body.health_update(body.healthDB.deplete_health(damage_points));
			queue_free();

