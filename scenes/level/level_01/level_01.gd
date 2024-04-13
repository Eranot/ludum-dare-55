extends Node2D

@onready var creature_spawner_player = %CreatureSpawnerPlayer
@onready var creature_spawner_enemy = %CreatureSpawnerEnemy
@onready var spell_grid = $UI/SpellGrid
@onready var ai_play_timer = $AiPlayTimer

@export var ai_timeout: float = 1
@export var ai_strategy: AiStrategy
@export var ai_credits: int = 5

func _ready():
	GameEvent.summon_creature.connect(on_summon_creature)
	enemy_spawn()
	
	choose_ai_strategy()
	await get_tree().create_timer(randi_range(1, 3)).timeout
	ai_play_timer.timeout.connect(on_ai_play_timer)
	ai_play_timer.start(randf_range(ai_timeout * 0.8, ai_timeout * 1.2))


func on_summon_creature(creature: Creature, x: int, y: int):
	creature_spawner_player.spawn(creature)
	
	var height = creature.get_design().size()
	var width = creature.get_design()[0].size()
	
	spell_grid.refill_grid(x, y, width, height)


func enemy_spawn():
	creature_spawner_enemy.spawn(load("res://resources/creatures/basic_soldier.tres"))


func choose_ai_strategy():
	ai_strategy = load("res://scenes/game_object/enemy_ai/rush_strategy.gd").new(creature_spawner_enemy)


func on_ai_play_timer():
	ai_credits += 1
	ai_credits = ai_strategy.play(ai_credits)
	ai_play_timer.start(randf_range(ai_timeout * 0.8, ai_timeout * 1.2))
