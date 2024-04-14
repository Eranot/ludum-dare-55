class_name Base
extends StaticBody2D

@onready var hp_bar = $HpBar
@onready var animated_sprite_2d = $AnimatedSprite2D


@export var max_hp: float = 20
@export var is_player: bool = true
@export var center: Node2D
var hp: int = 20

func _ready():
	hp = max_hp
	
	if is_player:
		collision_layer = 0x0100
	else:
		collision_layer = 0x1000
		
	update_animation()


func damage(value: int):
	hp -= value
	update_hp_bar()
	update_animation()
	if hp <= 0:
		GameEvent.emit_game_end(not is_player)


func update_hp_bar():
	hp_bar.value = hp / max_hp


func update_animation():
	if not is_player:
		animated_sprite_2d.flip_h = true
	
	var percent =  hp / max_hp
	if percent <= 0:
		animated_sprite_2d.play("0")
	elif percent <= 0.3:
		animated_sprite_2d.play("30")
	elif percent <= 0.6:
		animated_sprite_2d.play("60")
	else:
		animated_sprite_2d.play("100")
