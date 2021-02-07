extends KinematicBody2D
class_name Enemy

onready var coin = preload("res://Scenes/Coin/BaseCoin.tscn");

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
			queue_free();

func _loot():
	var coin_inst = coin.instance();
	coin_inst.global_position = global_position;
	get_tree().get_root().add_child(coin_inst);

func check_am_i_dead():
	if healthDB.health <=0:
		_loot();
		queue_free();
