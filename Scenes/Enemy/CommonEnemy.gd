extends "res://Scenes/Enemy/Enemy.gd"

enum DIRECTION{
	LEFT = -1,RIGHT=1
}
export(DIRECTION) var WALKING_DIRECTION;

var state;

onready var sprite : Sprite = $Sprite;
onready var floor_left : RayCast2D = $FloorLeft;
onready var floor_right : RayCast2D = $FloorRight;
onready var wall_left : RayCast2D = $WallLeft;
onready var wall_right : RayCast2D = $WallRight;

func _ready():
	state = WALKING_DIRECTION;
	
func _physics_process(delta):
	match state:
		DIRECTION.RIGHT:
			motion.x = Max_Speed;

			if not floor_right.is_colliding() or wall_right.is_colliding():
				state = DIRECTION.LEFT;
		DIRECTION.LEFT:
			motion.x = -Max_Speed;
			if not floor_left.is_colliding() or wall_left.is_colliding():
				state = DIRECTION.RIGHT;
				
	sprite.scale.x = sign(motion.x);
	motion = move_and_slide_with_snap(motion,Vector2.DOWN*4,Vector2.UP,true,4,deg2rad(46));

