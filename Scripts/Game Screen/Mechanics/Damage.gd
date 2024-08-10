extends Node2D

# Variables to store the properties of the entity
var damage: int             # Base damage dealt by the entity
var crit_chance: float      # Probability of a critical hit (percentage)
var crit_damage: float      # Multiplier applied to damage on a critical hit
var attack_range: int       # Range within which the entity can attack

# Called when the node is added to the scene
func _ready() -> void: 
	# Initialize the entity's properties with metadata values set in the scene
	damage = get_meta("StartingDamage")
	crit_chance = get_meta("StartingCritChance")
	crit_damage = get_meta("StartingCritDamage")
	attack_range = get_meta("StartingAttackRange")

# Getter and setter functions for the above variables
func get_damage() -> int:
	return damage

func get_crit_chance() -> float:
	return crit_chance

func get_crit_damage() -> float:
	return crit_damage

func get_attack_range() -> int:
	return attack_range

func set_damage(target_damage: int) -> void:
	damage = target_damage

func set_crit_chance(target_crit_chance: float) -> void:
	crit_chance = target_crit_chance

func set_crit_damage(target_crit_damage: float) -> void:
	crit_damage = target_crit_damage

func set_attack_range(target_attack_range: int) -> void:
	attack_range = target_attack_range

# Function to perform an attack on a target object
func attack(target_object: Node2D) -> void:
	var final_damage = damage  # Start with base damage
	# Calculate if a critical hit occurs (if crit_chance is higher than a random value between 0 and 100)
	if crit_chance > randf_range(0.0, 100.0):
		# If critical hit, apply crit_damage multiplier to the base damage
		final_damage = (crit_damage * damage) + damage
	# Get the target object's Health node
	var target_object_health = target_object.get_node("Health")
	# Apply the calculated damage to the target object's health
	target_object_health.take_damage(final_damage)
