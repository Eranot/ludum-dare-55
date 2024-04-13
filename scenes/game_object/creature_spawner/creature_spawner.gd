class_name CreatureSpawner
extends Node2D

@export var is_player: bool = true

@onready var area_2d: Area2D = $Area2D


func _ready():
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_entered)


func spawn(creature: Creature):
	var c = load(creature.game_object).instantiate()
	c.is_player = is_player
	c.creature = creature
	add_child(c)
	

func on_body_entered(body):
	if not is_player:
		return
	GameEvent.emit_spawn_enabled(not area_2d.has_overlapping_bodies())

