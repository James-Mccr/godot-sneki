extends Node2D

@export var tile = Vector2.ZERO

func set_tile(_tile:Vector2)->void:
	tile = _tile
	position = Grid.to_position(tile)

func rotate_by(next_tile):
	if (next_tile.x > tile.x):
		rotation_degrees = 0
	elif (next_tile.y > tile.y):
		rotation_degrees = 90
	elif (next_tile.x < tile.x):
		rotation_degrees = 180
	else:
		rotation_degrees = 270
		
