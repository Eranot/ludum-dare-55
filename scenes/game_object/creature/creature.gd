class_name CreatureBody
extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D
@export var hp : float = 10
@export var is_player: bool = true
@export var creature: Creature
@export var range_area_2d: Area2D
@export var attack_timer: Timer
@export var hp_bar: ProgressBar

var current_target: CreatureBody

func _ready():
	if is_player:
		collision_layer = 0x01
		collision_mask = 0x11
		range_area_2d.collision_mask = 0x10
	else:
		collision_layer = 0x10
		collision_mask = 0x11
		range_area_2d.collision_mask = 0x01
	
	range_area_2d.body_entered.connect(on_enemy_entered)
	attack_timer.timeout.connect(on_attack_timer)
	hp = creature.hp


func _physics_process(delta):
	var direction = 1 if is_player else -1
	if direction:
		velocity.x = direction * creature.speed
	else:
		velocity.x = move_toward(velocity.x, 0, creature.speed)
	
	if not is_player:
		animated_sprite_2d.flip_h = true
	
	move_and_slide()
	
	if animated_sprite_2d.animation == "attack" and animated_sprite_2d.is_playing():
		return
	
	if velocity:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("idle")


func on_enemy_entered(body):
	if body is CreatureBody:
		start_attacking_first_enemy()


func on_attack_timer():
	attack()


func start_attacking_first_enemy():
	if current_target:
		return
	
	var enemies = range_area_2d.get_overlapping_bodies()
	if enemies.size() == 0:
		return
	var enemy = enemies[0]
	current_target = enemy
	attack()


func attack():
	if not current_target or not is_instance_valid(current_target):
		current_target = null
		start_attacking_first_enemy()
		return
	
	animated_sprite_2d.play("attack")
	await animated_sprite_2d.animation_finished
	if is_instance_valid(current_target) and await current_target.damage(creature.attack):
		current_target = null
	attack_timer.start(creature.attack_cooldown)
	

func damage(value: int):
	hp -= value
	update_hp_bar()
	if hp <= 0:
		await get_tree().create_timer(0.05).timeout
		queue_free()
		return true
	return false


func update_hp_bar():
	hp_bar.value = hp / creature.hp