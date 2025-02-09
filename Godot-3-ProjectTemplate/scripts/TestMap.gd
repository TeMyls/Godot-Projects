extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print($TileMap.cell_size)
	$Player.set_tile_position(5,5,$TileMap.cell_size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
