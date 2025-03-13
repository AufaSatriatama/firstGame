extends CharacterBody2D

@export var speed: float = 350.0  # Kecepatan gerak
@export var maxHealth = 100
var currentHealth = 100


@onready var healthBarTexture = $CanvasLayer/Control/TextureRect
@onready var mainMenu = $CanvasLayer/mainMenu
@onready var pauseMenu = $CanvasLayer/pauseMenu
@onready var sisaMedKit = $CanvasLayer/powerUp/RichTextLabel
@onready var stunEnemy = $CanvasLayer/stunEnemy
@onready var enemyClass = get_node("/root/Node2D/enemy2/enemyFigure")
@onready var menangKalahClass = get_node("/root/Node2D/Player/CanvasLayer/menang")


var nilaiSisaMedKit = ""
var intSisaMedKit = 3

var relativePosition = Vector2.ZERO


var texturePath = "res://Assets/otherAssets/Lifebar/lifebar100%.png"
var movementLockedPause = false
var movementLocked = false
var movementLockedMenangKalah = false
var enemyStunned = false

#ngesent sinyal (pause) dari main menu

var pauseSignal = false

var timer = 0.0
var targetTime = 1.5



var integratedMovementLocked = false



func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("pause"):
		var pauseMenu = get_node("/root/Node2D/Player/CanvasLayer/pauseMenu")
		
		movementLockedPause = pauseMenu.pause(movementLockedPause)
		
func playerBeingAttacked(amount):
	currentHealth -= amount
	currentHealth = max(currentHealth, 0)
	updateHealthbar()
	return currentHealth

func attackEnemy():
	pass

func _process(delta):

	relativePosition = enemyClass.relativePosition
	

	#Sisa medkit
	nilaiSisaMedKit = sisaMedKit.get_text()
	intSisaMedKit = int(nilaiSisaMedKit)
	print(nilaiSisaMedKit)

	var is_attacking = false  # Status karakter (true = menyerang, false = diam)
	
	movementLocked = mainMenu.movementLocked

	movementLockedMenangKalah = menangKalahClass.movementLocked
	
	movementLockedPause = pauseMenu.movementLocked

	if movementLockedPause == true or movementLocked == true or movementLockedMenangKalah == true:
		integratedMovementLocked = true
	if movementLockedPause == false and movementLocked == false and movementLockedMenangKalah == false:
		integratedMovementLocked = false
	

	var direction = Vector2.ZERO
	if Input.is_action_pressed("move_right") and not integratedMovementLocked:
		direction.x += 3
	if Input.is_action_pressed("move_left") and not integratedMovementLocked:
		direction.x -= 3
	if Input.is_action_pressed("move_down") and not integratedMovementLocked:
		direction.y += 3
	if Input.is_action_pressed("move_up") and not integratedMovementLocked:
		direction.y -= 3
	#if Input.is_action_just_pressed("Attack"):
		#get_tree().change_scene_to_file("res://Scenes/attack.tscn")  # Ganti dengan path Scene B
	if Input.is_action_just_pressed("Attack") and not integratedMovementLocked:
		is_attacking = true
		update_animation(is_attacking)
		if enemyClass.calculationDistance < 5:
			enemyClass.takeDamage()


	if Input.is_action_just_pressed("testDamage") and not integratedMovementLocked:
		currentHealth = takeDamage(10)
		#currentHealth = playerBeingAttacked()
	if Input.is_action_just_pressed("medKit") and not integratedMovementLocked:
		if currentHealth < 100 and intSisaMedKit > 0:
			currentHealth += 10
			currentHealth = min(currentHealth, 100)
			intSisaMedKit -= 1
			sisaMedKit.set_text(str(intSisaMedKit))
			updateHealthbar()
		elif currentHealth == 100:
			print("Health is full")
		elif intSisaMedKit == 0:
			print("Medkit is empty")

	#Untuk ngestun musuh
	if Input.is_action_just_pressed("stunEnemy") and not integratedMovementLocked:
		stunEnemyFunction()


	timer  += delta
	if timer >= targetTime:
		timer = 0.0
		enemyStunned = false


	#Saat kalah
	if currentHealth <= 0:
		menangKalahClass.kalah()

	velocity = direction.normalized() * speed
	move_and_slide()
	
func _ready():
	currentHealth = maxHealth

	var mainMenu = get_node("/root/Node2D/Player/CanvasLayer/mainMenu")

	movementLocked = mainMenu.movementLocked
	
	updateHealthbar()

func updateHealthbar():
	
	var percentage = int(((currentHealth * 1.0) / maxHealth) * 100 )
	percentage = int(percentage / 10) * 10
	changeHealthBarTexture(percentage) 
	print(currentHealth)
	
func changeHealthBarTexture(percentage):
	
	
	if percentage == 100:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar100%.png"
	elif percentage == 90:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar90%.png"
	elif percentage == 80:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar80%.png"
	elif percentage == 70:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar70%.png"
	elif percentage == 60:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar60%.png"
	elif percentage == 50:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar50%.png"
	elif percentage == 40:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar40%.png"
	elif percentage == 30:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar30%.png"
	elif percentage == 20:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar20%.png"
	elif percentage == 10:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar10%.png"
	elif texturePath == 0:
		texturePath = "res://Assets/otherAssets/Lifebar/lifebar0%.png"
	
	
	print(texturePath)
	healthBarTexture.texture = load(texturePath)
	
func takeDamage(amount):
	currentHealth -= amount
	currentHealth = max(currentHealth, 0)
	updateHealthbar()
	return currentHealth

func update_animation(is_attacking):
	if $modeDiam.visible == true:
		$modeDiam.visible = not is_attacking
		$modeAttack.visible = is_attacking
		await get_tree().create_timer(0.5).timeout 
		update_animation(is_attacking)
	else:
		$modeAttack.visible = not is_attacking
		$modeDiam.visible = is_attacking


func stunEnemyFunction():
	enemyStunned = true

	
