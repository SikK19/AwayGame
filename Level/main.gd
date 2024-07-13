extends Node2D

@onready var Pause_Menu = $PauseMenu
var paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		Pause_Menu.hide()
		Engine.time_scale = 1
	else:
		Pause_Menu.show()
		Engine.time_scale = 0
		
	paused = !paused
