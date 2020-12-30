extends "res://Scripts/Enemy.gd"

export var armor = 12 setget setArmor
var offset = Vector2()
var instancedBloodPosition
var increaseVelocity = Vector2(10, 20)

#var mageSpells = [preload("res://Scenes/Enemies/IceBeam.tscn"), preload("res://Scenes/Enemies/FireWave.tscn")]
var bloodPool = preload("res://Scenes/Interface/BloodLifetime.tscn")

onready var shootTimer = get_node("ShootTimer")
onready var warriorElf = get_node("ElfAnimator")

func _ready():
	var _connection
	add_to_group("Enemy")
	chooseDirection()
	_connection = connect("area_entered", self, "areaEntered")
	warriorElf.play("WalkAnimation")
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
		enemyArea.armor -= 1
		queue_free()
		
func setArmor(newValue):
	armor = newValue
	velocity += increaseVelocity
	print(velocity)
	if armor <= 0:
		instancedBloodPosition = bloodPool.instance()
		instancedBloodPosition.set_position(get_global_position())
		get_tree().get_root().add_child(instancedBloodPosition)
		StoreHp.storedValue.totalPoints += int(rand_range(5, 10))
		StoreHp.save()
		queue_free()
