extends Node2D

@export var tile = Vector2.ZERO

func set_tile(_tile:Vector2)->void:
	tile = _tile
	position = Grid.to_position(tile)

func rotate_by(move_buffer):
	if (move_buffer == Grid.RIGHT):
		rotation_degrees = 0
	elif (move_buffer == Grid.LEFT):
		rotation_degrees = 180
	elif (move_buffer == Grid.DOWN):
		rotation_degrees = 90
	else:
		rotation_degrees = 270
