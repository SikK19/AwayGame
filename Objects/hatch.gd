extends StaticBody2D

@export var start_angle = 0
@export var end_angle = 90

func _ready():
	rotation = deg_to_rad(start_angle)

func activate(state = false):
	print("switch doorangle")
	if rotation == deg_to_rad(start_angle):
		rotation = deg_to_rad(end_angle)
	else:
		rotation = deg_to_rad(start_angle)
