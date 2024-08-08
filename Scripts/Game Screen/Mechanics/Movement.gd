extends Node2D

@onready var the_grid: TileMap
@onready var moveable: Node2D
enum MovingDirection {UP, DOWN, LEFT, RIGHT}
var swipe_start_position
var swipe_end_position
var has_dragged = false

func _ready() -> void:
	the_grid = get_node("/root/Game Screen/The Grid")
	moveable = get_parent()
	
	var cell_position = the_grid.local_to_map(moveable.global_position)
	moveable.global_position.x = the_grid.map_to_local(cell_position).x + 8
	moveable.global_position.y = the_grid.map_to_local(cell_position).y - 16
	

func _input(event: InputEvent) -> void:
	if get_meta("Controllable"):
		if event is InputEventScreenDrag:
			has_dragged = true
		if event is InputEventScreenTouch:
			if event.pressed:
				swipe_start_position = event.position
			elif not event.pressed:
				swipe_end_position = event.position
				if has_dragged:
					var swipe_direction := ""
					var distance_x = swipe_end_position.x - swipe_start_position.x
					var distance_y = swipe_end_position.y - swipe_start_position.y
					if abs(distance_x) > abs(distance_y): 
						if distance_x > 0:
							swipe_direction = "right"
						else:
							swipe_direction = "left"
					else:
						if distance_y > 0:
							swipe_direction = "down"
						else:
							swipe_direction = "up"
					print_debug(swipe_direction)
					move(string_to_movingdirection(swipe_direction))
					has_dragged = false
	else:
		pass

func move(direction: MovingDirection) -> void:
	var jump = get_meta("Jump")
	match direction:
		MovingDirection.UP:
			moveable.position.y = moveable.position.y - 32
		MovingDirection.DOWN:
			moveable.position.y = moveable.position.y + 32
		MovingDirection.LEFT:
			moveable.position.x = moveable.position.x - 32
		MovingDirection.RIGHT:
			moveable.position.x = moveable.position.x + 32

func string_to_movingdirection(string_direction: String) -> MovingDirection:
	match string_direction:
		"up": return MovingDirection.UP
		"down": return MovingDirection.DOWN
		"left": return MovingDirection.LEFT
		"right": return MovingDirection.RIGHT
		_: 
			printerr("Invalid direction string: ", string_direction)
			return MovingDirection.UP
