extends Node2D

var tile = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.gameover.connect(gameover)
	spawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sneki = get_parent().get_node("Sneki")
	if (sneki.get_node("Head").tile == tile):
		SignalBus.cherri_eaten.emit(tile)
		spawn()
		
func spawn():
	var sneki = get_parent().get_node("Sneki")
	var coordinates = sneki.get_snake_coordinates()
	var tileNew = Vector2(randi_range(0, Grid.grid_width_index), randi_range(0, Grid.grid_height_index))
	while (coordinates.find(tileNew) != -1):
		tileNew.x = randi_range(0, Grid.grid_width_index)
		tileNew.y = randi_range(0, Grid.grid_height_index)
	tile = tileNew
	position = Grid.to_position(tile)

func gameover():
	hide()
