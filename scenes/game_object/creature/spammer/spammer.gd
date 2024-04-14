extends CreatureBody

const SPAMMER_BULLET = preload("res://scenes/game_object/creature/spammer/spammer_bullet.tscn")

func on_start_attack():
	if not current_target:
		return
	
	var bullet = SPAMMER_BULLET.instantiate()
	add_sibling(bullet)
	bullet.global_position = self.center.global_position
	bullet.damage = self.creature.attack
	bullet.set_target(current_target)


func get_attack():
	return 0
