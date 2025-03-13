extends Control


@onready var playerClass = get_node("/root/Node2D/Player")
@onready var menangKalahMenu = $"."
@onready var menangKalahMenuText = $"RichTextLabel"
@onready var enemyClass = get_node("/root/Node2D/enemy2/enemyFigure")
#@onready var menangClass = get_node("/root/Node2D/Player/CanvasLayer/menang")

var movementLocked = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func onExitGameMenangPressed() -> void:
	
	get_tree().quit()
	
	

func onRestartGamePressed() -> void:

	get_tree().change_scene_to_file("res://game1.tscn")
	
func menang():
	
	#menangKalahMenuText.set_text("Selamat, Anda Menang!")
	menangKalahMenu.visible = true
	movementLocked = true


func kalah():
	
	menangKalahMenuText.set_text("You Lose!")
	menangKalahMenu.visible = true
	movementLocked = true

	