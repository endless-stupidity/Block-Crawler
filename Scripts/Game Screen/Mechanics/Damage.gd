extends Node2D

var damage: int
var crit_chance: float
var crit_damage: float
var attack_range: int

func _ready() -> void:
	damage = get_meta("StartingDamage")
	crit_chance = get_meta("StartingCritChance")
	crit_damage = get_meta("StartingCritDamage")
	attack_range = get_meta("StartingAttackRange")

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

func attack(target_object: Node2D) -> void:
	var final_damage = damage
	if crit_chance > randf_range(0.0, 100.0):
		final_damage = (crit_damage * damage) + damage
	var target_object_health = target_object.get_node("Health")
	target_object_health.take_damage(final_damage)
