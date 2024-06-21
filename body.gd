extends Node2D

var body_texture = preload("res://body.png")
var bend_texture = preload("res://bend.png")

@export var tile = Vector2.ZERO

func set_tile(_tile:Vector2)->void:
	tile = _tile
	position = Grid.to_position(tile)
	
func rotate_by(previous_tile, next_tile):
	var next_diff = next_tile - tile
	var previous_diff = previous_tile - tile
	
	if (next_diff.y == 0 && previous_diff.y == 0):
		$Sprite2D.texture = body_texture
		rotation_degrees = 0
	elif (next_diff.x == 0 && previous_diff.x == 0):
		$Sprite2D.texture = body_texture
		rotation_degrees = 90
	elif ((previous_diff == Grid.LEFT && next_diff == Grid.DOWN) || (previous_diff == Grid.DOWN && next_diff == Grid.LEFT)):
		$Sprite2D.texture = bend_texture
		rotation_degrees = 0
	elif ((previous_diff == Grid.LEFT && next_diff == Grid.UP) || (previous_diff == Grid.UP && next_diff == Grid.LEFT)):
		$Sprite2D.texture = bend_texture
		rotation_degrees = 90
	elif ((previous_diff == Grid.UP && next_diff == Grid.RIGHT) || (previous_diff == Grid.RIGHT && next_diff == Grid.UP)):
		$Sprite2D.texture = bend_texture
		rotation_degrees = 180
	else:
		$Sprite2D.texture = bend_texture
		rotation_degrees = 270
		
