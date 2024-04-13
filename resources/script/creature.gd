class_name Creature
extends Resource

@export_multiline var design: String
@export var icon: Texture
@export_file("*.tscn") var game_object: String
@export var speed: int = 20
@export var attack: int = 1
@export var hp: int = 3
@export var attack_cooldown: float = 1
@export var ai_credits: int = 5

func get_design() -> Array[Array]:
	var d: Array[Array] = []
	
	for line in design.split("\n"):
		var l = []
		
		for e in line.split(" "):
			match(e):
				"F":
					l.append(Enums.Element.FIRE)
				"W":
					l.append(Enums.Element.WATER)
				"E":
					l.append(Enums.Element.EARTH)
				"I":
					l.append(Enums.Element.WIND)
		d.append(l)
	return d
	
