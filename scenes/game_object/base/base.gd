class_name Base
extends StaticBody2D

@onready var hp_bar = $HpBar

@export var max_hp: float = 20
@export var hp: int = 20
@export var is_player: bool = true

func _ready():
	if is_player:
		collision_layer = 0x0100
	else:
		collision_layer = 0x1000


func damage(value: int):
	hp -= value
	update_hp_bar()
	if hp <= 0:
		GameEvent.emit_game_end(not is_player)


func update_hp_bar():
	hp_bar.value = hp / max_hp
