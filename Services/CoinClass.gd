class_name CoinClass

var coin : int = 0;
	
func default_coin():
	return coin;
	
func update_coin(amnt:int):
	coin = amnt;

func add_coin(amnt:int):
	return coin + amnt;
