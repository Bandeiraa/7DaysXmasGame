extends "res://Scripts/Enemy.gd"

export (int) var armor = 6 setget setArmor

var offset = Vector2()
var instancedBloodPosition
var spell

var lancerSpells = [preload("res://Scenes/Enemies/LancerSpear.tscn"), preload("res://Scenes/Enemies/Arrow.tscn")]
var bloodPool = preload("res://Scenes/Interface/BloodLifetime.tscn")

onready var shootTimer = get_node("ShootTimer")
onready var lancerElf = get_node("ElfAnimator")

func _ready():
	var _connection
	add_to_group("Enemy")
	chooseDirection()
	_connection = connect("area_entered", self, "areaEntered")
	lancerElf.play("WalkAnimation")
	shoot()
	
func shoot():
	randomize()
	var randomIndex = randi() % 10 + 1
	print(randomIndex)
	if randomIndex > 7:
		spell = lancerSpells[0].instance()
		spell.set_position(get_global_position())
		get_tree().get_root().call_deferred("add_child", spell)
	else:
		spell = lancerSpells[1].instance()
		spell.set_position(get_global_position())
		get_tree().get_root().call_deferred("add_child", spell) 
	shootTimer.start()
	
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
		CameraShake.shake(5, 0.2)
		enemyArea.armor -= 1
		queue_free()
		
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		instancedBloodPosition = bloodPool.instance()
		instancedBloodPosition.set_position(get_global_position())
		get_tree().get_root().add_child(instancedBloodPosition)
		StoreHp.storedValue.totalPoints += int(rand_range(3, 7))
		StoreHp.save()
		queue_free()

func onSpearTimeout():
	shoot()
