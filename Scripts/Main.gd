extends Node2D

var loadGoblin = preload("res://Scenes/Character/Goblin.tscn")
var loadText = preload("res://Scenes/Interface/Dialogue.tscn")
var loadEnemy = preload("res://Scenes/Enemies/EnemySpawner.tscn")

onready var goblinSpawner = get_node("GoblinSpawner")
onready var dialogueSpawner = get_node("DialogueSpawner")
onready var enemySpawner = get_node("EnemySpawner")

var spawnCurrentPosition
var key = false
var spawnKey = false
signal canSpawn

export(int) var yDistanceOffset = 27
export(int) var velocityOffset = 35

func _ready():
	var character = loadGoblin.instance()
	var label = loadText.instance()
	goblinSpawner.add_child(character)
	dialogueSpawner.add_child(label)
	spawnCurrentPosition = goblinSpawner.get_position()
	label.connect("canClose", self, "canCall")
	
func canSpawn():
	var enemies = loadEnemy.instance()
	enemySpawner.add_child(enemies)
	
func canCall():
	key = true

func _process(delta):
	if key == true:
		spawnCurrentPosition.y -= delta * velocityOffset
		var viewSize = get_viewport_rect().size
		if spawnCurrentPosition.y >= viewSize.y - yDistanceOffset:
			goblinSpawner.position.y = spawnCurrentPosition.y
			spawnKey = true
		elif spawnKey == true:
			emit_signal("canSpawn")
			spawnKey = false
