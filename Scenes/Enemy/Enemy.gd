extends KinematicBody2D
class_name Enemy
var damage_points : int = 1;

export(int) var Max_Speed = 4;
var motion : Vector2 = Vector2.ZERO;

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		print("Bruhhh")
		if !body.healthDB.health == 0:
			body.health_update(body.healthDB.deplete_health(damage_points));
			queue_free();

