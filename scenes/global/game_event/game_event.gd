extends Node

var is_spawn_enabled: bool = true

signal summon_creature(creature: Creature, x: int, y: int)
signal spawn_enabled(enabled: bool)
signal game_end(won: bool)
signal reset_grid

func emit_summon_creature(creature: Creature, x: int, y: int):
	summon_creature.emit(creature, x, y)


func emit_spawn_enabled(enabled: bool):
	spawn_enabled.emit(enabled)
	is_spawn_enabled = enabled


func emit_game_end(won: bool):
	game_end.emit(won)


func emit_reset_grid():
	reset_grid.emit()
