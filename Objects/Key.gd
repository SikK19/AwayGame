extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default") # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func interact(body):
	body.take_key()
	if body.has_key:
		print("Key taken")
	$AnimatedSprite2D.visible = false
	queue_free()


func _on_area_2d_body_entered(body):
	#this should only ever interact with the human!!!!
	body.has_key = true
	queue_free()
