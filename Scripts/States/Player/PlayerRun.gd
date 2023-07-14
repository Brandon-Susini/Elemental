extends State
class_name PlayerRun

@export var player : CharacterBody2D
@onready var anim = player.get_node("AnimatedSprite2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func enter():
	anim.animation = "run"
	anim.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta):
	if abs(player.velocity.x) == 0 && player.is_on_floor():
		transitioned.emit(self, "idle")
	if player.velocity.y < 0:
		transitioned.emit(self,"jump")
	pass
	
