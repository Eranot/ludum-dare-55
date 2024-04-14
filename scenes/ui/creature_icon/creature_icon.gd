extends PanelContainer

@onready var texture_rect = $TextureRect
@export var creature: Creature
@export var x: int
@export var y: int
@export var enabled: bool = true

func _ready():
	gui_input.connect(on_gui_input)
	enabled = GameEvent.is_spawn_enabled
	GameEvent.spawn_enabled.connect(on_spawn_enabled)
	GameEvent.reset_grid.connect(on_reset_grid)


func on_gui_input(event: InputEvent):
	if event is InputEventMouseButton \
		and event.pressed \
		and event.double_click \
		and enabled \
		and event.button_index == MOUSE_BUTTON_LEFT:
		summon()


func on_spawn_enabled(_enabled: bool):
	enabled = _enabled
	update_icon()


func on_reset_grid():
	queue_free()


func set_creature(c: Creature, _x: int, _y: int):
	creature = c 
	self.x = _x
	self.y = _y
	update_icon()


func update_icon():
	texture_rect.texture = creature.icon
	texture_rect.self_modulate = "#ffffff" if enabled else "#565656"
	
	update_minimum_size()
	force_update_transform()
	texture_rect.update_minimum_size()
	texture_rect.force_update_transform()


func summon():
	GameEvent.emit_summon_creature(creature, x, y)
	self.queue_free()
