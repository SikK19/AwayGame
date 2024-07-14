extends Camera2D

@export var bird:Node2D
@export var human:Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_position.x = (bird.global_position.x + human.global_position.x)/2
	global_position.y = (bird.global_position.y + human.global_position.y)/2
