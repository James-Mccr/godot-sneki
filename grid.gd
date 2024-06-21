extends Node

var grid_width = 0
var grid_width_index = 0
var grid_height = 0
var grid_height_index = 0
var tile_width = 16
var tile_width_offset = 8
var tile_height = 16
var tile_height_offset = 8
const LEFT = Vector2(-1,0)
const RIGHT = Vector2(1,0)
const UP = Vector2(0,-1)
const DOWN = Vector2(0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	var viewport = get_viewport()
	grid_width = viewport.size.x/tile_width
	grid_width_index = grid_width-1
	grid_height = viewport.size.y/tile_height
	grid_height_index = grid_height-1

func to_offset(tile:Vector2)->Vector2:
	return Vector2(tile.x*tile_width, tile.y*tile_height)

func to_position(tile:Vector2)->Vector2:
	return Vector2(tile.x*tile_width+tile_width_offset, tile.y*tile_height+tile_height_offset)
	
func out_of_bounds(tile:Vector2)->bool:
	return tile.x < 0 || tile.x > grid_width_index || tile.y < 0 || tile.y > grid_height_index
