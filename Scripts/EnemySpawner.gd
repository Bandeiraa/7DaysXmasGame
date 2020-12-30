extends Node2D

var enemies = [preload("res://Scenes/Enemies/Reindeer.tscn")]
var elfs = [preload("res://Scenes/Enemies/MageElf.tscn"), preload("res://Scenes/Enemies/LancerElf.tscn"), preload("res://Scenes/Enemies/WarriorElf.tscn")]
onready var spawnTimer = get_node("SpawnElfTimer")
onready var spawnReinTimer = get_node("SpawnReinTimer")

func _ready():
	spawnRein()
	spawnElf()
	
func chooseWhoSpawn(choice):
	randomize()
	var randomIndex = randi() % choice.size()
	return choice[randomIndex]

func spawnRein():
	randomize()
	var enemy = enemies[0].instance()
	var enemyPosition = Vector2()
	enemyPosition.x = rand_range(0, get_viewport().get_visible_rect().size.x - 41)
	enemy.set_position(enemyPosition)
	self.add_child(enemy)
	var randomWaitTime = rand_range(3, 10)
	spawnReinTimer.set_wait_time(randomWaitTime)
	spawnReinTimer.start()
		
func spawnElf():
	randomize()
	var elf = chooseWhoSpawn(elfs).instance()
	var elfPosition = Vector2()
	elfPosition.x = rand_range(0 - 3, get_viewport().get_visible_rect().size.x - 44)
	elf.set_position(elfPosition)
	self.add_child(elf)
	var randomWaitTime = rand_range(1.0, 3.5)
	spawnTimer.set_wait_time(randomWaitTime)
	spawnTimer.start()

func onSpawnTimeout():
	spawnElf()

func onSpawnReinTimeout():
	spawnRein()
