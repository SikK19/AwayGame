extends CharacterBody2D

var rock_scene = load("res://Characters/Human Character/rock_projectile/rock_projectile.tscn")
var throw_force = 1000
var can_throw = true

var facing_direction = 1
var has_key = false
var is_climbing = false

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var bird:Node2D
var is_bird_on_human = false

@onready var animations = $Animations

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Camera2D.bird = bird

func _physics_process(delta):
	if (velocity.x > 0 || velocity.x < 0) && velocity.y == 0:
		animations.play("Running")
	if velocity == Vector2(0,0):
		animations.play("Idle")
	if velocity.y > 0 && not is_climbing:
		animations.play("Jumping")
	if velocity.y > 0 && is_climbing:
		animations.play("Climbing")
	
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_pressed("jump"):
		if $"ladder detector".get_overlapping_areas().size() >0:
			velocity.y = -SPEED
		elif is_on_floor():
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		facing_direction = direction
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	#calls the interact function on an interactable item, the interactable object does the rest
	if Input.is_action_just_pressed("interact"):
		var a = $"interact box".get_overlapping_areas()
		if a.size() > 0 and not a.size() >=2:

			a[0].interact(self)
			
	if direction > 0:
		animations.flip_h = false
		if is_bird_on_human:
			bird.sprite_idle.flip_h = false
		$"throwing_arm/throwing test sprite".position.x = 93
		$"throwing_arm/throwing test sprite".position.y = -2
	if direction < 0:
		animations.flip_h = true
		if is_bird_on_human:
			bird.sprite_idle.flip_h = true
		$"throwing_arm/throwing test sprite".position.x = -93
		$"throwing_arm/throwing test sprite".position.y = 20
	
	#play the wobbly arm
	if Input.is_action_pressed("throw") and can_throw:
		$throwing_arm/AnimationPlayer.play("throw_wobble")
	if Input.is_action_just_released("throw") and $throwing_arm/AnimationPlayer.is_playing():
		#create a new rock scene, throw it in the direction of the player is currently aiming in
		var rock = rock_scene.instantiate()
		get_parent().add_child(rock)
		rock.global_position = $throwing_arm.global_position
		rock.linear_velocity = Vector2(throw_force * facing_direction,0).rotated($throwing_arm.rotation * facing_direction)
		
		$throwing_arm/AnimationPlayer.stop()
		
		can_throw = false
		$rock_throw_cooldown.start()

func _on_rock_throw_cooldown_timeout():
	can_throw = true

func loose_key():
	has_key = false
	#TODO: Ui updaten

func damage():
	print("human damaged")
	#TODO: do something when damage is taken, for example restart the level

