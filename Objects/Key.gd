extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func interact(body):
	body.take_key()
	if body.has_key:
		print("Key taken")
	$AnimatedSprite2D.visible = false
	queue_free()