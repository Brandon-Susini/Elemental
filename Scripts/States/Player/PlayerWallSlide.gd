extends State
class_name PlayerWallSlide

@export var player : CharacterBody2D
@onready var anim = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func enter():
	anim.animation = "wall_slide"
	anim.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if player.is_on_floor():
		transitioned.emit(self, 'idle')
	if !player.is_on_wall():
		transitioned.emit(self, 'jump')
		
	if Input.is_action_just_pressed("jump"):
		transitioned.emit(self, "walljump")
	pass
