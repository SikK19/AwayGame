extends Area2D

@export var area_left:Area2D
@export var area_right:Area2D
@export var bird:Node2D

var wind_force = 0

func _ready():
	$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not area_left.has_overlapping_areas() && not area_right.has_overlapping_areas():
		wind_force = 0
	if area_left.has_overlapping_areas():
		wind_force += 10
		print("wind_force: " + str(wind_force))
		bird.velocity.x += wind_force
	if area_right.has_overlapping_areas():
		wind_force += 10
		print("wind_force: " + str(wind_force))
		bird.velocity.x -= wind_force
