extends KinematicBody2D
class_name NPC

var velocity = Vector2.ZERO

var target = null

export var friction = 0.3
export var acceleration = 0.5
var rotation_dir = 1
var rotation_speed = 1.5
export var move_speed = 200.00
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func follow_target(target, delta):
	if target:
		velocity = global_position.direction_to(target)
		if global_position.distance_to(target) > 5:	
			
			velocity = move_and_slide(velocity * move_speed)
	else:
		velocity = Vector2.ZERO
