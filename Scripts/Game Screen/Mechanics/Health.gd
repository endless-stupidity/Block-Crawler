extends Node2D

var max_health: int
var health: int

func _init() -> void:
	max_health = get_meta("StartingMaxHealth")
	health = max_health

func get_max_health() -> int:
	return max_health

func get_health() -> int:
	return health

func set_max_health(target_max_health: int) -> void:
	max_health = target_max_health
	if health > max_health:
		health = max_health

func set_health(target_health: int) -> void:
	health = target_health
	if health > target_health:
		health = max_health
