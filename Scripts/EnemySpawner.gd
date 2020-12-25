extends Node2D

var enemies = [preload("res://Scenes/Enemies/Reindeer.tscn")]

func _ready():
	spawnEnemy()

func spawnEnemy():
	while true:
		randomize()
		var enemy = enemies[0].instance()
		var enemyPosition = Vector2()
		enemyPosition.x = rand_range(0 - 3, get_viewport().get_visible_rect().size.x - 44)
		enemy.set_position(enemyPosition)
		self.add_child(enemy)
		yield(get_tree().create_timer(rand_range(3, 10)), "timeout")
