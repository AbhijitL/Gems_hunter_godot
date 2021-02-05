extends KinematicBody2D

onready var axe = $Axe;

export (int) var ACCELERATION = 212;
export(int) var MAX_SPEED = 50;
export(float) var FRICTION = 0.25;
export(int) var GRAVITY = 200;
export(int) var Max_SLOPE_ANGLE = 46;
export(int) var JUMP_FORCE = 128;


var motion : Vector2 = Vector2.ZERO;
var snap_vector : Vector2 = Vector2.ZERO;
var just_jumped : bool = false;
var axe_visible : bool = false;

onready var sprite : Sprite = $Sprite;
onready var sprite_animator : AnimationPlayer = $AnimationPlayer;
onready var cjump_timer : Timer = $CJump;
onready var ui = $UINODE/UI2;
onready var recharge_timer : Timer = $RechargeTimer;

var self_pause : bool = false;


var healthDB : HealthClass = HealthClass.new();
var coinDB : CoinClass = CoinClass.new();
var staminaDB : StaminaClass = StaminaClass.new();

func _ready():
	health_update(healthDB.default_health());
	update_stamina(staminaDB.default_stamina());
	if axe.visible:
		axe.visible = false;
		

func _physics_process(delta):
	if !self_pause:
		just_jumped = false;
		var input_vector : Vector2 = get_input_vector();
		apply_horizontal_force(input_vector,delta);
		apply_friction(input_vector);
		update_snap_vector();
		jump_check();
		apply_gravity(delta);
		update_animations(input_vector);
		move();
		input_vector = Vector2(0,0);
	else:
		sprite_animator.play("rest");

	
func get_input_vector():
	var input_vector : Vector2 = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left");
	return input_vector;
	
func apply_horizontal_force(input_vector,delta):
	if input_vector.x != 0:
		motion.x +=  input_vector.x * ACCELERATION * delta;
		motion.x = clamp(motion.x,-MAX_SPEED,MAX_SPEED);

func apply_friction(input_vector):
	if input_vector.x == 0 and is_on_floor():
		motion.x = lerp(motion.x,0,FRICTION);

func update_snap_vector():
	if is_on_floor():
		snap_vector = Vector2.DOWN;		

func jump_check(): 
	if is_on_floor() or cjump_timer.time_left > 0:
		if Input.is_action_just_pressed("ui_up"):
			motion.y = - JUMP_FORCE;
			just_jumped = true;
			snap_vector = Vector2.ZERO;
			
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE / 2:
			motion.y = -JUMP_FORCE / 2;
			

func apply_gravity(delta):
	motion.y += GRAVITY * delta;
	motion.y = min(motion.y,JUMP_FORCE);

func update_animations(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x);
		axe.scale.x = sign(input_vector.x);
		sprite_animator.play("run");
	else:
		sprite_animator.play("idle");
		
	if not is_on_floor():
		sprite_animator.play("jump");
	

func move():
	var was_in_air : bool = not is_on_floor();
	var was_on_floor : bool = is_on_floor();
	var last_motion = motion;
	var last_position = position;
	motion = move_and_slide_with_snap(motion,snap_vector*4,Vector2.UP,true,4,deg2rad(Max_SLOPE_ANGLE));
	
	#landing
	if was_in_air and is_on_floor():
		motion.x = last_motion.x;
				
	#just left ground	
	if was_on_floor and not is_on_floor() and not just_jumped:
		motion.y = 0;
		position.y = last_position.y;
		cjump_timer.start();

func _input(event):
	if event.is_action_pressed("Attack"):
		_attack();
	if event.is_action_released("Attack"):
		axe.visible = false;
	if event.is_action_pressed("Recharge"):
		_recharge_stamina();

func health_update(amnt : int):
	healthDB.update_health(amnt);
	var hp : int = healthDB.health;
	$UINODE/UI2._update_hp_ui(hp)
	
func coin_update(amnt:int):
	coinDB.update_coin(amnt);
	$Jems/CoinLabel.text = str(coinDB.coin);

func update_stamina(amnt:int):
	staminaDB.update_stamina(amnt);
	print(staminaDB.stamina);

func _attack():
	if !staminaDB.stamina <= 0:
		axe.visible = true;
		staminaDB.deplete_stamina(50);
		var stamina : int = staminaDB.stamina;
		ui._update_stamina_ui(stamina);
		print(staminaDB.stamina);
	
func _recharge_stamina():
	if staminaDB.stamina == 0:
		recharge_timer.start();
		self_pause = true;
		VisualServer.set_default_clear_color(Color("#43523d"));

func _on_RechargeTimer_timeout():
	staminaDB.add_stamina(staminaDB.max_stamina);
	print(staminaDB.stamina);
	ui._update_stamina_ui(staminaDB.stamina);
	self_pause = false;
	VisualServer.set_default_clear_color(Color("#c7f0d8"));
