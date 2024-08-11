extends Node2D

# Variables of the armor entity
var armor_amount: int    # How much of the damage the armor reduces
var armor_health: int    # How much health the armor currently has
var health_loss: int     # How much health is reduced from armor by each hit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the initial values based on the metadata fields
	armor_amount = get_meta("ArmorAmount")
	armor_health = get_meta("ArmorHealth")
	health_loss = get_meta("HealthLossPerDamage")

# Getter and setter functions for the above variables
func get_armor_amount() -> int:
	return armor_amount

func get_armor_health() -> int:
	return armor_health

func get_health_loss() -> int:
	return health_loss

func set_armor_amount(target_amount: int) -> void:
	armor_amount = target_amount

func set_armor_health(target_health: int) -> void:
	armor_health = target_health

func set_armor_health_loss(target_health_loss: int) -> void:
	health_loss = target_health_loss

# Calculate the taken damage based on the armor amount and health, return the
# taken damage
func take_hit(damage: int) -> int:
	var final_damage = damage
	if armor_health > 0:
		final_damage = damage - armor_amount
		armor_health -= health_loss
	if final_damage < 0:
		final_damage = 0
	return final_damage
