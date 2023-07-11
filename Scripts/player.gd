extends CharacterBody2D

@export var walk_speed = 200
@export var run_speed = 400
@export var jump_height = 600
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var grounded
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.animation = "idle"
	$AnimatedSprite2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	pass
	
	
# Add a state machine
func _physics_process(delta):
	velocity.y += (gravity *delta)
	var running = {"status": 0}

	if Input.is_action_pressed("left"):
		velocity.x = -walk_speed
		running.status = -1
		
	elif Input.is_action_pressed("right"):
		velocity.x = walk_speed
		running.status = 1
	else:
		if is_on_floor():
			$AnimatedSprite2D.animation = "idle"
			velocity.x = 0
			
	if running.status != 0 && is_on_floor():
		$AnimatedSprite2D.animation = "run"
		if running.status == -1:
			$AnimatedSprite2D.flip_h = true
		elif running.status == 1:
			$AnimatedSprite2D.flip_h = false
	
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y -= jump_height
		$AnimatedSprite2D.animation = "jump"
		grounded = false
		
#	if is_on_floor() && !grounded:
#		$AnimatedSprite2D.animation = "land"
#		grounded = true
	$AnimatedSprite2D.play()
	move_and_slide()
