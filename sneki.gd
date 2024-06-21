extends Node2D

var move_buffer = Vector2(1,0)
var move = Vector2(1,0)
const moves_per_second = 7
const delta_per_move = 1.0/moves_per_second
var delta_sum = 0
var eaten_cherris = []
var head
var tail
var bodies = []

func _ready():
	head = load("res://head.tscn").instantiate()
	head.set_tile(Vector2(1,0))
	add_child(head)
	tail = load("res://tail.tscn").instantiate()
	tail.set_tile(Vector2.ZERO)
	add_child(tail)
	SignalBus.cherri_eaten.connect(_on_eat)
		
func _process(delta):	
	if (Input.is_action_pressed("ui_left") && move != Grid.RIGHT):
		move_buffer = Grid.LEFT
	elif (Input.is_action_pressed("ui_right") && move != Grid.LEFT):
		move_buffer = Grid.RIGHT
	elif (Input.is_action_pressed("ui_up") && move != Grid.DOWN):
		move_buffer = Grid.UP
	elif (Input.is_action_pressed("ui_down") && move != Grid.UP):
		move_buffer = Grid.DOWN
		
	delta_sum += delta
	if (delta_sum < delta_per_move):
		return
	delta_sum = 0
		
	move = move_buffer
	var head = get_node("Head")
	var new_tile = head.tile+move
	if (Grid.out_of_bounds(new_tile)):
		SignalBus.gameover.emit()
		hide()
		return	# game over
	for coordinate in get_snake_coordinates():
		if (coordinate == new_tile):
			SignalBus.gameover.emit()
			hide()
			return
	
	var tail = get_node("Tail")
	var spawn = false
	for cherri in eaten_cherris:
		if (cherri == tail.tile):
			eaten_cherris.erase(cherri)
			spawn = true
			break
			
	if (spawn):
		var body = load("res://body.tscn").instantiate()
		body.set_tile(head.tile)
		if (bodies.is_empty()):
			body.rotate_by(tail.tile, new_tile)
		else:
			body.rotate_by(bodies.front().tile, new_tile)
		bodies.insert(0, body)
		add_child(body)
	elif (bodies.is_empty()):
		tail.set_tile(head.tile)
		tail.rotate_by(new_tile)
	else:
		tail.set_tile(bodies.back().tile)
		bodies.back().set_tile(head.tile)
		if (bodies.size() == 1):
			bodies.back().rotate_by(tail.tile, new_tile)
		else:
			bodies.back().rotate_by(bodies.front().tile, new_tile)
		bodies.push_front(bodies.pop_back())
		tail.rotate_by(bodies.back().tile)
	head.set_tile(new_tile)
	head.rotate_by(move)
	
func _on_eat(tile):
	eaten_cherris.append(tile)
	
func get_snake_coordinates():
	var coordinates = []
	coordinates.push_back(head.tile)
	for body in bodies:
		coordinates.push_back(body.tile)
	coordinates.push_back(tail.tile)
	return coordinates
