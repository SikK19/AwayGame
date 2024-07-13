extends Area2D

@export var conected_objects:Array[Node2D]

var state = true

func interact():
	if state:
		$state1.visible = false
		$state2.visible = true
		state = false
	else:
		$state1.visible = true
		$state2.visible = false
		state = true
	
	for o in conected_objects:
		o.activate(state)
