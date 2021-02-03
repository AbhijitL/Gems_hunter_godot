extends KinematicBody2D

export (int) var ACCELERATION = 212;
export(int) var MAX_SPEED = 50;
export(float) var FRICTION = 0.25;
export(int) var GRAVITY = 200;
export(int) var Max_SLOPE_ANGLE = 46;
export(int) var JUMP_FORCE = 128;


var motion : Vector2 = Vector2.ZERO;

onready var sprite : Sprite = $Sprite;
onready var sprite_animator : AnimationPlayer = $AnimationPlayer;

func _physics_process(delta):
	var input_vector : Vector2 = get_input_vector();
	apply_horizontal_force(input_vector,delta);
	apply_friction(input_vector);
	jump_check();
	apply_gravity(delta);
	update_animations(input_vector);
	move();
	input_vector = Vector2(0,0);
	
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
		

func jump_check(): 
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = - JUMP_FORCE;
	else:
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE / 2:
			motion.y = -JUMP_FORCE / 2;
			

func apply_gravity(delta):
	motion.y += GRAVITY * delta;
	motion.y = min(motion.y,JUMP_FORCE);

func update_animations(input_vector):
	if input_vector.x != 0:
		sprite.scale.x = sign(input_vector.x);
		sprite_animator.play("run");
	else:
		sprite_animator.play("idle");
		
	if not is_on_floor():
		sprite_animator.play("jump");

func move():
	motion = move_and_slide_with_snap(motion,Vector2.DOWN*4,Vector2.UP,true,4,deg2rad(Max_SLOPE_ANGLE));



