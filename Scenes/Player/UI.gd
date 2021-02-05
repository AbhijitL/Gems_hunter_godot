extends HBoxContainer

onready var heart = load("res://Sprites/Player/heart.png");

onready var gridCont = $VBoxContainer2/MarginContainer/Container;
onready var staminaProgres : TextureProgress = $VBoxContainer/MarginContainer/StaminProgress;
	
func _create_heart():
	var textureRect = TextureRect.new();
	textureRect.texture = heart;
	gridCont.add_child(textureRect);

func _update_hp_ui(health:int):
	for i in gridCont.get_children():
		i.queue_free();	
	
	for i in health:
		_create_heart();

func _update_stamina_ui(amnt:int):
	staminaProgres.value = amnt;
