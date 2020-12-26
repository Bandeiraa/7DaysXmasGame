extends "res://Scripts/Enemy.gd"

export var armor = 6 setget setArmor
var offset = Vector2()
#var mageSpells = [preload("res://Scenes/Enemies/IceBeam.tscn"), preload("res://Scenes/Enemies/FireWave.tscn")]
onready var labelAnimation = get_node("Animator")
onready var damageLabel = get_node("DamageLabel")
onready var deathTimer = get_node("DeathTimer")
onready var shootTimer = get_node("ShootTimer")

func _ready():
	var _connection
	add_to_group("Enemy")
	chooseDirection()
	_connection = connect("area_entered", self, "areaEntered")
	#shoot()
	
func chooseDirection():
	randomize()
	var direction = ["left", "right"]
	var chooseDirection = direction[randi() % direction.size()]
	match chooseDirection:
		"left":
			velocity.x = velocity.x
		"right":
			velocity.x = -velocity.x
			
func _process(_delta):
	if get_position().x <= 0 + 10:
		velocity.x = abs(velocity.x)
	if get_position().x >= get_viewport_rect().size.x - 10:
		velocity.x = -abs(velocity.x)
		
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		deathTimer.start()
		enemyArea.armor -= 1
		labelAnimation.play("DamageAnimation")
		damageLabel.text = str(-1)
		velocity.y = 0
		velocity.x = 0
		$EnemySprite.hide()
		print("Vida do player: ", enemyArea.armor)
		
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		queue_free()
		
func onDeathTimeout():
	queue_free()
