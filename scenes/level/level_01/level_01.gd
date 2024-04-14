extends Node2D

@onready var creature_spawner_player = %CreatureSpawnerPlayer
@onready var creature_spawner_enemy = %CreatureSpawnerEnemy
@onready var spell_grid = %SpellGrid
@onready var reset_grid_button = %ResetGridButton
@onready var ai_play_timer = $AiPlayTimer
@onready var reset_grid_timer = $ResetGridTimer


@export var ai_timeout: float = 1
@export var ai_strategy: AiStrategy
@export var ai_credits: int = 5

func _ready():
	GameEvent.summon_creature.connect(on_summon_creature)
	GameEvent.game_end.connect(on_game_end)
	reset_grid_button.pressed.connect(on_reset_grid_button_pressed)
	reset_grid_timer.timeout.connect(on_reset_grid_timer_timeout)
	
	choose_ai_strategy()
	await get_tree().create_timer(randi_range(1, 3)).timeout
	
	ai_play_timer.timeout.connect(on_ai_play_timer)
	ai_play_timer.start(randf_range(ai_timeout * 0.8, ai_timeout * 1.2))


func on_summon_creature(creature: Creature, x: int, y: int):
	creature_spawner_player.spawn(creature)
	
	var height = creature.get_design().size()
	var width = creature.get_design()[0].size()
	
	spell_grid.refill_grid(x, y, width, height)



func choose_ai_strategy():
	ai_strategy = load("res://scenes/game_object/enemy_ai/rush_strategy.gd").new(creature_spawner_enemy)


func on_ai_play_timer():
	ai_credits += 1
	ai_credits = ai_strategy.play(ai_credits)
	ai_play_timer.start(randf_range(ai_timeout * 0.8, ai_timeout * 1.2))


func on_reset_grid_timer_timeout():
	reset_grid_button.disabled = false


func on_game_end(won: bool):
	print("WON: ", won)
	get_tree().paused = true


func on_reset_grid_button_pressed():
	GameEvent.emit_reset_grid()
	reset_grid_button.disabled = true
	reset_grid_timer.start()
