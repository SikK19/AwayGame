extends StaticBody2D

@export var active:bool = true


func _ready():
	$CollisionShape2D.disabled = active
	#$rain.visible = active
	
	$rain.size = $CollisionShape2D.shape.size
	$rain.position = $CollisionShape2D.position - $CollisionShape2D.shape.size / 2
	
	
	

