extends Node2D

onready var intro_timer : Timer = $IntroTimer;
onready var intro = $ViewportContainer/Viewport/Intro;
onready var cont_screen = $ViewportContainer/Viewport/Continue;
onready var menu = $ViewportContainer/Viewport/Menu;
onready var play_button = $ViewportContainer/Viewport/Menu/Control/VBoxContainer2/HBoxContainer/VBoxContainer/Play;

func _ready():
	_start_up();

func _start_up():
	intro_timer.start()


func _on_IntroTimer_timeout():
	intro.visible = false;
	cont_screen.visible = true
	
func _input(event):
	if not menu.visible:
		if event.is_action_pressed("ui_accept") and not intro.visible:
			cont_screen.visible = false;
			menu.visible = true;play_button.grab_focus();
		



