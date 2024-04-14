class_name SpellElement
extends PanelContainer

signal pressed(element: SpellElement)

@export var element: Enums.Element
@onready var texture_rect = $MarginContainer/TextureRect

var is_used: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_element()
	deselect()
	self.gui_input.connect(on_gui_input)


func on_gui_input(event: InputEvent):
	if event is InputEventMouseButton \
		and event.pressed \
		and not is_used \
		and event.button_index == MOUSE_BUTTON_LEFT:
		pressed.emit(self)


func set_element(e: Enums.Element):
	element = e
	update_icon()


func update_element():
	element = randi_range(1, 3) as Enums.Element
	update_icon()


func update_icon():
	match(element):
		Enums.Element.RED:
			texture_rect.texture = preload("res://assets/sprites/ui/element/red.png")
		Enums.Element.GREEN:
			texture_rect.texture = preload("res://assets/sprites/ui/element/green.png")
		Enums.Element.BLUE:
			texture_rect.texture = preload("res://assets/sprites/ui/element/blue.png")


func select():
	get("theme_override_styles/panel").set("bg_color", "#99ff99")


func deselect():
	get("theme_override_styles/panel").set("bg_color", "#999999")
