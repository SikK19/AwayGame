extends Area2D

var already_activated = false
@export var start_position:Vector2= Vector2(0,0)
@export var end_position:Vector2 = Vector2(0,1000)

func _ready():
	var animation = $AnimationPlayer.get_animation("ladder drop")

	var track = animation.find_track("ladder:position", Animation.TYPE_VALUE)
	var last_key = animation.track_get_key_count(track) - 1

	animation.track_set_key_value(track, 0, start_position)
	animation.track_set_key_value(track, last_key, end_position)

func activate():
	if not already_activated:
		$AnimationPlayer.play("ladder drop")
		already_activated = true
