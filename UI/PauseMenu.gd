extends Control

@onready var level = $"../../"


func _on_resume_pressed():
	level.pauseMenu()


func _on_quit_pressed():
	get_tree().quit()
