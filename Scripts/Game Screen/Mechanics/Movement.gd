extends Node2D

# Declare onready variables to store references to the grid (TileMap) and the moveable object (Node2D)
@onready var the_grid: TileMap 
@onready var moveable: Node2D

# Enumeration to represent the four possible moving directions
enum MovingDirection {UP, DOWN, LEFT, RIGHT}

# Variables to store the start and end positions of a swipe gesture
var swipe_start_position
var swipe_end_position

# Boolean flag to track whether a dragging gesture has occurred
var has_dragged = false

# Called when the node is added to the scene
func _ready() -> void:
	# Initialize the_grid to the TileMap node in the scene
	the_grid = get_node("/root/Game Screen/The Grid")
	# Initialize moveable to the parent node to be moved
	moveable = get_parent()
	
	# Calculate the cell position of the moveable object on the grid
	var cell_position = the_grid.local_to_map(moveable.global_position)
	# Adjust the global position of the moveable object to align it with the grid, with slight offsets
	moveable.global_position.x = the_grid.map_to_local(cell_position).x + 8
	moveable.global_position.y = the_grid.map_to_local(cell_position).y - 16

# Called whenever an input event (such as touch or drag) occurs
func _input(event: InputEvent) -> void:
	# Only process input events if the node has the "Controllable" metadata
	if get_meta("Controllable"):
		# If the event is a screen drag, set has_dragged to true
		if event is InputEventScreenDrag:
			has_dragged = true
		# If the event is a screen touch, handle swipe start and end positions
		if event is InputEventScreenTouch:
			if event.pressed:
				# Store the starting position of the swipe
				swipe_start_position = event.position
			elif not event.pressed:
				# Store the ending position of the swipe
				swipe_end_position = event.position
				# If a drag gesture was detected, determine the swipe direction
				if has_dragged:
					var swipe_direction := ""
					# Calculate the distance swiped in the x and y directions
					var distance_x = swipe_end_position.x - swipe_start_position.x
					var distance_y = swipe_end_position.y - swipe_start_position.y
					# Determine the primary swipe direction based on which axis has a larger movement
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
					# Print the swipe direction for debugging purposes
					print_debug(swipe_direction)
					# Call the move function with the corresponding direction
					move(string_to_movingdirection(swipe_direction))
					# Reset has_dragged to false after the move
					has_dragged = false
	else:
		pass  # Do nothing if the node is not controllable

# Function to move the object in a specified direction
func move(direction: MovingDirection) -> void:
	# Retrieve the "Jump" value from the node's metadata
	var jump = get_meta("Jump")
	# Move the object in the specified direction by adjusting its position
	match direction:
		MovingDirection.UP:
			moveable.position.y = moveable.position.y - 32 * jump
		MovingDirection.DOWN:
			moveable.position.y = moveable.position.y + 32 * jump
		MovingDirection.LEFT:
			moveable.position.x = moveable.position.x - 32 * jump
		MovingDirection.RIGHT:
			moveable.position.x = moveable.position.x + 32 * jump

# Function to convert a string direction into a MovingDirection enumeration value
func string_to_movingdirection(string_direction: String) -> MovingDirection:
	match string_direction:
		"up": return MovingDirection.UP
		"down": return MovingDirection.DOWN
		"left": return MovingDirection.LEFT
		"right": return MovingDirection.RIGHT
		_: 
			# Print an error if an invalid string direction is provided
			printerr("Invalid direction string: ", string_direction)
			# Default to returning UP if the direction is invalid
			return MovingDirection.UP
