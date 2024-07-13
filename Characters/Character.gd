extends Node2D  # You can change this to Sprite or KinematicBody2D if needed

var speed = 200  # Speed of the object moving towards the cursor
var amplitude = 50  # Amplitude of the sine wave
var frequency = 2  # Frequency of the sine wave

var start_position: Vector2
var time_passed: float = 0

func _ready():
	start_position = position  # Save the starting position

func _process(delta):
	time_passed += delta  # Increment time passed

	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - position).normalized()
	var distance = (mouse_position - position).length()
	
	# Horizontal movement towards the mouse position
	if distance > 1:  # Small threshold to stop jittering when close
		position += direction * speed * delta

	# Sinusoidal vertical movement
	position.y = start_position.y + amplitude * sin(frequency * time_passed)
