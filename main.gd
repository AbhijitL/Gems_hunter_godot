extends Node2D

onready var intro_timer : Timer = $IntroTimer;
onready var cutscene_timer : Timer = $CutsceneTimer;
onready var intro = $ViewportContainer/Viewport/Intro;
onready var cont_screen = $ViewportContainer/Viewport/Continue;
onready var menu = $ViewportContainer/Viewport/Menu;
onready var play_button = $ViewportContainer/Viewport/Menu/Control/VBoxContainer2/HBoxContainer/VBoxContainer/Play;
onready var cutscene = $ViewportContainer/Viewport/Intro_Entrance;

func _ready():
	_start_up();

func _start_up():
	intro_timer.start()


func _on_IntroTimer_timeout():
	intro.visible = false;
	$ViewportContainer/Viewport/Intro_Entrance.visible = true;
	$CutsceneTimer.start();
	
	
func _input(event):
	if not menu.visible:
		if event.is_action_pressed("ui_accept") and not intro.visible and not cutscene.visible:
			cont_screen.visible = false;
			menu.visible = true;play_button.grab_focus();


func _on_CutsceneTimer_timeout():
	cont_screen.visible = true;
	cutscene.visible = false;
