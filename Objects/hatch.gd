extends Node2D

@export var start_angle = 0
@export var end_angle = 90

func _ready():
	$hinge.set_deferred("rotation", deg_to_rad(start_angle))
	$Sprite2D.frame = (start_angle/90)

func activate(_state = false):
	if !$MovingSound.playing:
		$MovingSound.play()
	if abs(float(rad_to_deg($hinge.rotation) - start_angle))< 0.001: # if you are at start angle
		$hinge.set_deferred("rotation", deg_to_rad(end_angle))
		$Sprite2D.frame = (end_angle/90)
	else:
		$hinge.set_deferred("rotation", deg_to_rad(start_angle))
		$Sprite2D.frame = (start_angle/90)
	

