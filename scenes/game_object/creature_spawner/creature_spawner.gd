class_name CreatureSpawner
extends Node2D

@export var is_player: bool = true
@onready var area_2d: Area2D = $Area2D


func _ready():
	area_2d.body_entered.connect(on_body_entered)
	area_2d.body_exited.connect(on_body_entered)
	
	if is_player:
		area_2d.collision_mask = 0x0001
	else:
		area_2d.collision_mask = 0x0010


func spawn(creature: Creature) -> bool:
	if area_2d.has_overlapping_areas():
		return false
	
	var c = load(creature.game_object).instantiate()
	c.is_player = is_player
	c.creature = creature
	add_child(c)
	return true
	

func on_body_entered(_body):
	if not is_player:
		return
	
	GameEvent.emit_spawn_enabled(not area_2d.has_overlapping_bodies())

