class_name HealthClass

const max_health : int = 3;		
var health : int = max_health;
	
func default_health():
	return health;
	
func update_health(amnt:int):
	health = amnt;

func add_health(amnt:int):
	if health + amnt > 3:
		return max_health;
	else:
		return health + amnt;

func deplete_health(amount:int):
	if health - amount < 0:
		return max_health - max_health;#return 0
	else:
		return health - amount;
