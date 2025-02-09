extends KinematicBody2D
class_name PC
#if these values are 1 it's immediate
export var friction = 0.2
export var acceleration = 0.3
var rotation_dir = 0.1
var rotation_speed = 1.5
export var move_speed = 300.00

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height)/ jump_time_to_peak) * -1.0
onready var jump_gravity : float =  ((-2.0 * jump_height)/ (jump_time_to_peak*jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height)/ (jump_time_to_descent*jump_time_to_descent)) * -1.0
onready var target = position

#if tile based 
onready var tween_tile = $Tween

onready var ray = $RayCast2D
var tween_speed = 10
var tile_size = 64
var inputs = {"ui_right": Vector2.RIGHT,
			"ui_left": Vector2.LEFT,
			"ui_up": Vector2.UP,
			"ui_down": Vector2.DOWN}


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



	
func get_gravity():
	return jump_gravity if velocity.y else fall_gravity

func apply_gravity(delta):
	velocity.y += get_gravity() * delta

func jump():
	if Input.is_action_just_pressed("ui_up"):
		#jump
		if is_on_floor():
			velocity.y = jump_velocity

func platformer_input():
	var dir_x = 0
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
	if dir_x != 0:
		velocity.x = lerp(velocity.x, dir_x * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	velocity = move_and_slide(velocity)
	#return horizontal

func directional_input():
	#velocity = Vector2()
	
	var dir_x = 0
	var dir_y = 0
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
		
	
	
	
	if Input.is_action_pressed("ui_down"):
		dir_y += 1
	if Input.is_action_pressed("ui_up"):
		dir_y -= 1
		
	if dir_x != 0 and dir_y != 0:
		var dir_xy = Vector2(dir_x, dir_y).normalized()
		dir_x = dir_xy.x
		dir_y = dir_xy.y
		
	if dir_x != 0:
		velocity.x = lerp(velocity.x, dir_x * move_speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	
	if dir_y != 0:
		velocity.y = lerp(velocity.y, dir_y * move_speed, acceleration)
	else:
		velocity.y = lerp(velocity.y, 0, friction)

	

		
	velocity = move_and_slide(velocity)
	
	

func rotate_move_input(delta):
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2(-move_speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(move_speed, 0).rotated(rotation)
	rotation += rotation_dir * rotation_speed * delta
	velocity = velocity.normalized() * move_speed
	velocity = move_and_slide(velocity)



func click_input():
	if Input.is_action_pressed("click"):
		target = get_global_mouse_position()
	velocity = global_position.direction_to(target) * move_speed
	# look_at(target)
	if global_position.distance_to(target) > 5:	
		velocity = move_and_slide(velocity)
		

func set_tile_position(x,y,size_tile):
	tile_size = size_tile
	position.x = x * tile_size.x
	position.y = y * tile_size.y


func tile_based_input():
	if tween_tile.is_active():
		return
		
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			#position += inputs[dir] * tile_size
			ray.cast_to = inputs[dir] * tile_size
			ray.force_raycast_update()
			if ray.is_colliding() == false:
				tween_tile.interpolate_property(self, "position", position, position + inputs[dir] * tile_size,1.0/tween_speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				tween_tile.start()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
