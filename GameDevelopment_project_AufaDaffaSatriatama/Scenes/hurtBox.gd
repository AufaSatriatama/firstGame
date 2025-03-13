class_name hurtBox
extends Area2D


func _init() -> void:
	collision_layer = 0
	collision_mask = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#area_entered.connect("") 
	# Replace with function body.
	pass
	#connect("area_entered", self, "on_area_entered")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
