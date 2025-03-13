extends Control

@onready var main_menu = $"."

var movementLocked = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func onStartGamePressed() -> void:
	print("Start button pressed!")
	
	main_menu.visible = false
	movementLocked = false
	pass # Replace with function body.



func onExitGamePressed() -> void:
	main_menu.visible = false
	
	pass # Replace with function body.


