extends AiStrategy

var creatures_available: Array[Creature] = [
	load("res://resources/creatures/trojan.tres"),
	load("res://resources/creatures/spammer.tres"),
	load("res://resources/creatures/zero_day.tres")
]

var creature_spawner: CreatureSpawner

var next_creature: Creature

func _init(_creature_spawner: CreatureSpawner):
	creature_spawner = _creature_spawner
	choose_next_creature()


func play(credits: int) -> int:
	if credits > next_creature.ai_credits:
		if creature_spawner.spawn(next_creature):
			choose_next_creature()
			return credits - next_creature.ai_credits
	return credits

func choose_next_creature():
	next_creature = creatures_available.pick_random()
