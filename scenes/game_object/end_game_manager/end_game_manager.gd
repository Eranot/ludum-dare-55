extends Control

@onready var next_level_button = %NextLevelButton
@onready var try_again_button = %TryAgainButton
@onready var title = %Title
@onready var description = %Description

@export_file var next_level_file: String

func _ready():
	hide()
	next_level_button.pressed.connect(on_next_level_button)
	try_again_button.pressed.connect(on_try_again_button)


func set_win():
	get_tree().paused = true
	show()
	next_level_button.show()
	try_again_button.hide()
	title.text = "VICTORY"
	description.text = "Congratulations! Let's try a harder AI =)"


func set_lose():
	get_tree().paused = true
	show()
	next_level_button.hide()
	try_again_button.show()
	title.text = "DEFEAT"
	description.text = "Today wasn't your day, maybe next time?"
	

func on_next_level_button():
	get_tree().paused = false
	get_tree().change_scene_to_file(next_level_file)


func on_try_again_button():
	get_tree().paused = false
	get_tree().reload_current_scene()

