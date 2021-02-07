extends Node2D

onready var collision_area : CollisionShape2D = $Area2D/CollisionShape2D;


func play_anim():
	$AnimationPlayer.play("attack_anim");


func _on_Area2D_body_entered(body):
	if body.get_meta("type") == "enemy" and !collision_area.disabled:
		print("enemy hitted");
		body.health_update(body.healthDB.deplete_health(1));
		body.check_am_i_dead();
