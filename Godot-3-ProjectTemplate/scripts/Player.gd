extends PC


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


onready var screen_size = get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

		
func screen_wrap(box_w,box_h):
	if global_position.x > box_w:
		global_position.x = 0
	if global_position.x < 0:
		global_position.x = box_w
		
	if global_position.y > box_h:
		global_position.y = 0
	if global_position.y < 0:
		global_position.y = box_h

func _physics_process(delta):
	#tile_based_input()
	directional_input()
	print(velocity)
	
	screen_wrap(screen_size.x,screen_size.y)
	
