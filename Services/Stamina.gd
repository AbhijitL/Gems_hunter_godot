class_name StaminaClass

const max_stamina : int = 100;		
var stamina : int = max_stamina;
	
func default_stamina():
	return stamina;
	
func update_stamina(amnt:int):
	stamina = amnt;

func deplete_stamina(amount:int):
	if stamina - amount < 0:
		update_stamina(max_stamina - max_stamina);
	else:
		update_stamina(stamina - amount);
		
func add_stamina(amnt:int):
	if amnt > 100:
		update_stamina(max_stamina);
	else:
		update_stamina(stamina + amnt);
