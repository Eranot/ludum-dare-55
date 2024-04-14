extends Panel

const SPELL_ELEMENT = preload("res://scenes/ui/spell_element/spell_element.tscn")
const CREATURE_ICON = preload("res://scenes/ui/creature_icon/creature_icon.tscn")

@export var columns: int = 4
@export var lines: int = 4
@export var creatures: Array[Creature]

@onready var grid_container = $MarginContainer/GridContainer

var element_selected = null

# Called when the node enters the scene tree for the first time.
func _ready():
	grid_container.columns = self.columns
	
	for i in range(columns * lines):
		var element = SPELL_ELEMENT.instantiate()
		grid_container.add_child(element)
		element.pressed.connect(on_element_select)
	
	await get_tree().create_timer(0.05).timeout
	check_for_creatures()


func on_element_select(element: SpellElement):
	if element_selected:
		swap(element_selected, element)
		element_selected = null
		check_for_creatures()
		return
	
	element.select()
	element_selected = element


func swap(first: SpellElement, second: SpellElement):
	var temp = first.element
	first.set_element(second.element)
	second.set_element(temp)
	first.deselect()
	second.deselect()


func refill_grid(x: int, y: int, width: int, height: int):
	for i in range(height):
		for j in range(width):
			var e = get_element(x + j, y + i)
			e.update_element()
			e.is_used = false
	
	check_for_creatures()

func check_for_creatures():
	for creature in creatures:
		for y in lines:
			for x in columns:
				if check_creature(x, y, creature):
					create_creature(x, y, creature)


func check_creature(x: int, y: int, creature: Creature):
	var design = creature.get_design()
	for i in range(design.size()):
		for j in design[i].size():
			if x + j >= columns:
				return false
			if y + i >= lines:
				return false
			
			var element = get_element(x + j, y + i)
			if element.is_used:
				return false
			
			if element.is_used or design[i][j] != element.element:
				return false
	
	return true

func create_creature(x: int, y: int, creature: Creature):
	var design = creature.get_design()
	for i in range(design.size()):
		for j in design[i].size():
			var element = get_element(x + j, y + i)
			element.is_used = true
	
	var element = get_element(x, y)
	var c = CREATURE_ICON.instantiate()
	self.add_child(c)
	c.global_position = element.global_position
	c.set_creature(creature, x, y)
	

func get_element(x: int, y: int) -> SpellElement:
	return grid_container.get_child(y * columns + x)
	
