extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


@export var speed: float = 20
var playerPosition
var targetPosition
var direction 
var enemyPosition

var calculationDistance

var relativePosition = Vector2.ZERO
var menangCuy = false

@export var enemyHealth: int = 30
var enemyMaxHealth = 30

#ASSUME ADA FUNGSI takeDamage()

var attackRange
var movementLockedPause = false
var movementLocked = false

var integratedMovementLocked = false

@onready var enemyAttackClass = $"enemyAttack"
@onready var player = get_parent().get_parent().get_node("Player")
@onready var enemy = $"."
@onready var mainMenu = get_node("/root/Node2D/Player/CanvasLayer/mainMenu")
@onready var pauseMenu = get_node("/root/Node2D/Player/CanvasLayer/pauseMenu")
@onready var menangKalahMenu = get_node("/root/Node2D/Player/CanvasLayer/menang")

var enemyStunned = false
var isAttacking = false

func _ready() -> void:
	enemyHealth = enemyMaxHealth
	enemyPosition = global_position
	relativePosition = Vector2.ZERO
	enemyAttackClass.visible = false
	$enemyStatic.visible = true


	#if position.distance_to(playerPosition) == 4:
	#	velocity = Vector2.ZERO
	#	move_and_slide()



	#elif position.distance_to(playerPosition) > 4:
		#position = position + targetPosition * SPEED * delta
	#	velocity = targetPosition * SPEED 
	#	move_and_slide()
	



	
func get_distance_to_player() -> float:
	if player:
		return global_position.distance_to(player.global_position)
	return 0.0


func _process(delta):

	if menangCuy:
		$enemyStatic.visible = false
		enemyAttackClass.visible = false
		return

	playerPosition = player.global_position
	enemyPosition = global_position
	#enemyPosition = enemy.global_position
	direction = (player.global_position - global_position).normalized()
	#targetPosition = -1 * (global_position - playerPosition).normalized() 
	var distance = playerPosition.distance_to(enemyPosition)

	relativePosition = playerPosition - enemyPosition

	calculationDistance = (((playerPosition) * (playerPosition) - (enemyPosition) * (enemyPosition))/100000).length()
	#var anotherDistance = (playerPosition - enemyPosition).length()
	#var mathDistance = (playerPosition.x - enemyPosition.x) * (playerPosition.x - enemyPosition.x) + (playerPosition.y - enemyPosition.y) * (playerPosition.y - enemyPosition.y)

	enemyStunned = player.enemyStunned


	print("Distance to player: ", calculationDistance) 
	print("Player's distance: ", distance)
	print("integratedMovementLocked: ", integratedMovementLocked)
	print("Enemy stunned: ", enemyStunned)
	print("Enemy health: ", enemyHealth)
#	print("Player's distance global: ", distance)
#	print("Another distance: ", anotherDistance)
#	print("Math distance: ", mathDistance)
	
	if integratedMovementLocked == false and enemyStunned == false:
		if calculationDistance > 0.08  and calculationDistance < 3 and not menangCuy:
			attackMode(isAttacking)
			velocity = direction * SPEED
				
		else:
			#attackMode(isAttacking)
			enemyAttackClass.visible = false
			isAttacking = false
			$enemyStatic.visible = true
			velocity = Vector2.ZERO

		#velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO

	
	movementLockedPause = pauseMenu.movementLocked

	movementLocked = mainMenu.movementLocked

	

	integratedMovementLocked = player.integratedMovementLocked
	
	if movementLockedPause == true or movementLocked == true:
		integratedMovementLocked = true
	if movementLockedPause == false and movementLocked == false:
		integratedMovementLocked = false


	move_and_slide()





func takeDamage():
	enemyHealth -= 10
	if enemyHealth <= 0:
		enemyHealth = 0
		$enemyStatic.visible = false
		$enemyAttack.visible = false
		udahMenang()


func attackMode(isAttacking):
	#Enabling
	if not isAttacking:
		enemyAttackClass.visible = true
		isAttacking = true
		$enemyStatic.visible = false
		if calculationDistance < 1:
			player.playerBeingAttacked(0.2)


	else:
		enemyAttackClass.visible = false
		isAttacking = false
		$enemyStatic.visible = true


func udahMenang():
	$enemyStatic.visible = false
	enemyAttackClass.visible = false
	menangCuy = true
	menangKalahMenu.menang()
	