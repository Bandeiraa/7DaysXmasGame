extends Node2D

var loadGoblin = preload("res://Scenes/Character/Goblin.tscn")
var loadText = preload("res://Scenes/Interface/Dialogue.tscn")

onready var goblinSpawner = get_node("GoblinSpawner")
onready var dialogueSpawner = get_node("DialogueSpawner")

var spawnCurrentPosition
var key = false

export(int) var yDistanceOffset = 27
export(int) var velocityOffset = 35

func _ready():
	var character = loadGoblin.instance()
	var label = loadText.instance()
	goblinSpawner.add_child(character)
	dialogueSpawner.add_child(label)
	spawnCurrentPosition = goblinSpawner.get_position()
	label.connect("canClose", self, "canCall")
	
func canCall():
	key = true

func _process(delta):
	if key == true:
		spawnCurrentPosition.y -= delta * velocityOffset
		var viewSize = get_viewport_rect().size
		if spawnCurrentPosition.y >= viewSize.y - yDistanceOffset:
			goblinSpawner.position.y = spawnCurrentPosition.y
