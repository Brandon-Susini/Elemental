extends State
class_name PlayerJump

@export var player : CharacterBody2D
@onready var anim = player.get_node("AnimatedSprite2D")
@onready var camera = player.get_node("Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enter():
	anim.animation = 'jump'
	anim.play()
	
	
	
func exit():
	pass
	

func update(delta):
	if Input.is_action_just_pressed("down"):
		# Fast fall
		player.velocity.y += 200
	if player.is_on_floor():
		transitioned.emit(self, "land")
	pass


func _on_player_wall_sliding():
	transitioned.emit(self, 'wallslide')
	pass # Replace with function body.
