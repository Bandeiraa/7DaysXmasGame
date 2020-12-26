extends Node2D

var enemies = [preload("res://Scenes/Enemies/Reindeer.tscn")]
var elfs = [preload("res://Scenes/Enemies/MageElf.tscn"), preload("res://Scenes/Enemies/LancerElf.tscn"), preload("res://Scenes/Enemies/WarriorElf.tscn")]

func _ready():
	spawnRein()
	spawnElf()
	
func chooseWhoSpawn(choice):
	randomize()
	var randomIndex = randi() % choice.size()
	return choice[randomIndex]
	pass

func spawnRein():
	while true:
		randomize()
		var enemy = enemies[0].instance()
		var enemyPosition = Vector2()
		enemyPosition.x = rand_range(0 - 3, get_viewport().get_visible_rect().size.x - 44)
		enemy.set_position(enemyPosition)
		self.add_child(enemy)
		yield(get_tree().create_timer(rand_range(3, 10)), "timeout")
		
func spawnElf():
	while true:
		randomize()
		var elf = chooseWhoSpawn(elfs).instance()
		var elfPosition = Vector2()
		elfPosition.x = rand_range(0 - 3, get_viewport().get_visible_rect().size.x - 44)
		elf.set_position(elfPosition)
		self.add_child(elf)
		yield(get_tree().create_timer(rand_range(1.5, 3)), "timeout")
