extends StaticBody2D

@export var active:bool = true

func _ready():
	$CollisionShape2D.set_deferred("disabled", not active)
	$rain.visible = active
	
	$rain.size = $CollisionShape2D.shape.size
	$rain.position = $CollisionShape2D.position - $CollisionShape2D.shape.size / 2
	
	$damage_box/CollisionShape2D.position = $CollisionShape2D.position
	$damage_box/CollisionShape2D.shape.size = $CollisionShape2D.shape.size * 0.9
	$damage_box/CollisionShape2D.set_deferred("disabled", not active)
	
func activate():
	$CollisionShape2D.set_deferred("disabled", not $CollisionShape2D.disabled)
	$damage_box/CollisionShape2D.set_deferred("disabled", not $damage_box/CollisionShape2D.disabled)
	print($rain.visible)
	$rain.visible = not $rain.visible
	print($rain.visible)

