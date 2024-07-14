extends Area2D

@export var conected_objects:Array[Node2D]

var state = true

func interact(_player):
	$PushLever.play()
	if state:
		$AnimatedSprite2D.play("state1")
		state = false
	else:
		$AnimatedSprite2D.play("state2")
		state = true
	
	for o in conected_objects:
		o.activate(state)
