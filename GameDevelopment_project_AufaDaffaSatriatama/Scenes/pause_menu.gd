extends Control



#Status apakah menu lagi nyala atau tidak
var status = false

@onready var pauseMenu = $"."

var movementLocked = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if status == true:
		movementLocked = true
	else:
		movementLocked = false

	pass

#Fungsi ketika pause ditekan
func pause(movementLocked) -> void:

	if status:
		pauseMenu.visible = false
		status = false
		movementLocked = false
	else:
		pauseMenu.visible = true
		status = true
		movementLocked = true




func onExitGamePausePressed() -> void:

	get_tree().quit()

	

func onContinueGamePressed() -> void:
	
	if status:
		pauseMenu.visible = false
		status = false
		movementLocked = false
	else:
		pauseMenu.visible = true
		status = true
		movementLocked = true
	
