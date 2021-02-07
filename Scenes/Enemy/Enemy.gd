extends KinematicBody2D
class_name Enemy


var damage_points : int = 1;
var enemy_health : int = 2;

var Max_Speed : int = 4;
var motion : Vector2 = Vector2.ZERO;

var healthDB : HealthClass = HealthClass.new();

func _ready():
	self.set_meta("type","enemy");
	health_update(enemy_health);


func health_update(amnt : int):
	healthDB.update_health(amnt);

func _on_Area2D_body_entered(body):
	if body.get_name() == "Player":
		print("Bruhhh")
		if !body.healthDB.health == 0:
			body.health_update(body.healthDB.deplete_health(damage_points));
			body.check_am_i_dead();
			queue_free();

func check_am_i_dead():
	if healthDB.health <=0:
		queue_free();
