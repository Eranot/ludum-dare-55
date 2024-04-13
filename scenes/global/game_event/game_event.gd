extends Node

var is_spawn_enabled: bool = true

signal summon_creature(creature: Creature, x: int, y: int)
signal spawn_enabled(enabled: bool)

func emit_summon_creature(creature: Creature, x: int, y: int):
	summon_creature.emit(creature, x, y)


func emit_spawn_enabled(enabled: bool):
	spawn_enabled.emit(enabled)
	is_spawn_enabled = enabled
