extends CreatureBody

@export var explosion_area: Area2D
@onready var explosion_particles = $ExplosionParticles

func _ready():
	super._ready()
	
	explosion_area.collision_layer = self.range_area_2d.collision_layer
	explosion_area.collision_mask = self.range_area_2d.collision_mask

func on_start_attack():
	if not current_target:
		return
	
	var enemies = explosion_area.get_overlapping_bodies()
	
	for enemy in enemies:
		enemy.damage(5)
	
	explosion_particles.emitting = true
	self.animated_sprite_2d.visible = false
	self.hp_bar.visible = false
	await explosion_particles.finished
	self.damage(100)


func get_attack():
	return 0
