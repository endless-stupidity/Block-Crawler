extends Node2D

# Variable to access the entity's armor if available
var armor: Node2D
# Variables to store the maximum health and current health of the entity
var max_health: int  # Maximum health value
var health: int      # Current health value

# Called when the node is added to the scene
func _ready() -> void:
	# Initialize max_health with a value from metadata and set current health to max_health
	max_health = get_meta("StartingMaxHealth")
	health = max_health
	# Get a reference to the Armor node if it exists
	armor = get_node("../Armor")

# Getter and setter functions for health and max health
func get_max_health() -> int:
	return max_health

func get_health() -> int:
	return health

func set_max_health(target_max_health: int) -> void:
	max_health = target_max_health
	# Ensure that current health does not exceed the new max_health value
	if health > max_health:
		health = max_health

func set_health(target_health: int) -> void:
	health = target_health
	# Ensure health does not exceed max_health, correct the condition
	if health > max_health:
		health = max_health

# Function to apply damage to the entity; can be expanded to consider armor, resistance, etc.
func take_damage(taken_damage: int, damage_type: String = "Normal") -> void:
	var final_damage = taken_damage
	# Calculate the final damage based on the resistance of the given damage type (recieve lower
	# damage with higher values, recieve more damage with negative values)
	final_damage = final_damage - ((final_damage * get_meta(damage_type + "DamageResistance")) / 100)
	# If the object has an armor component, call the method
	if armor != null:
		final_damage = armor.take_hit(final_damage)
	health -= final_damage
