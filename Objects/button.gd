extends Area2D

@export var conected_objects:Array[Node2D]


func interact(_player):
	$Button_Sound_Player.play()
	for o in conected_objects:
		o.activate()
	
	
