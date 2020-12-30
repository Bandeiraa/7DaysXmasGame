extends "res://Scripts/Enemy.gd"

export var armor = 4 setget setArmor

var offset = Vector2()
var spell
var mageSpells = [preload("res://Scenes/Enemies/IceBeam.tscn"), preload("res://Scenes/Enemies/IceWave.tscn")]

signal slow
onready var shootTimer = get_node("ShootTimer")
onready var mageElf = get_node("ElfAnimator")

func _ready():
	var _connection
	add_to_group("Enemy")
	chooseDirection()
	_connection = connect("area_entered", self, "areaEntered")
	mageElf.play("Walk")
	shoot()
	
func shoot():
	randomize()
	var skill = get_node("SkillSpawn")
	var randomIndex = randi() % 10 + 1
	if randomIndex > 6:
		spell = mageSpells[0].instance()
		spell.set_position(get_global_position())
		get_tree().get_root().add_child(spell)
	else:
		spell = mageSpells[1].instance()
		skill.add_child(spell)  
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
		enemyArea.armor -= 1
		print("Vida do player: ", enemyArea.armor)
		queue_free()
		
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		StoreHp.storedValue.totalPoints += int(rand_range(1, 5))
		StoreHp.save()
		queue_free()
		
func canSlow():
	emit_signal("slow")
		
func onShootTimeout():
	shoot()
