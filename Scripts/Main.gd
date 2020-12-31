extends Node2D

var loadGoblin = preload("res://Scenes/Character/Goblin.tscn")
var loadText = preload("res://Scenes/Interface/Dialogue.tscn")
var loadEnemy = preload("res://Scenes/Enemies/EnemySpawner.tscn")
var playerHUD = preload("res://Scenes/Interface/Hud.tscn")
var goblin; var points = 0

onready var goblinSpawner = get_node("GoblinSpawner")
onready var dialogueSpawner = get_node("DialogueSpawner")
onready var enemySpawner = get_node("EnemySpawner")
onready var hudSpawner = get_node("HudSpawner")
onready var animator = get_node("DamageAnimation")
onready var snowFall = get_node("SnowAnimator")
onready var snowFallAux = get_node("SnowAnimatorAux")

var spawnCurrentPosition
var key = false
var spawnKey = false
var currentHp = false
signal canSpawn

export(int) var yDistanceOffset = 67
export(int) var velocityOffset = 70

func _ready():
	snowFall.play("SnowAnimation")
	snowFallAux.play("SnowFall")
	var label = loadText.instance()
	var hud = playerHUD.instance()
	hudSpawner.add_child(hud)
	dialogueSpawner.add_child(label)
	spawnCurrentPosition = goblinSpawner.get_position()
	label.connect("canClose", self, "canCall")
	StoreHp.storedValue.totalPoints = 0
	StoreHp.save()
	
func canSpawn():
	var enemies = loadEnemy.instance()
	enemySpawner.add_child(enemies)
	
func canCall():
	goblin = loadGoblin.instance()
	goblinSpawner.add_child(goblin)
	key = true
	
func updateHp():
	StoreHp.loadData()
	var convertToString = str(StoreHp.storedValue.currentHp)
	$HudSpawner/Hud/PlayerStatsContainer/Health.text = "Vida: " + convertToString
	animator.play("Damage")
	currentHp = false
	
func _process(delta):
	if key == true:
		spawnCurrentPosition.y -= delta * velocityOffset
		var viewSize = get_viewport_rect().size
		if spawnCurrentPosition.y >= viewSize.y - yDistanceOffset:
			$GoblinSpawner/Goblin/WalkAnimation.play("RightAnim")
			goblinSpawner.position.y = spawnCurrentPosition.y
			spawnKey = true
		elif spawnKey == true:
			emit_signal("canSpawn")
			spawnKey = false
			currentHp = true
	if currentHp:
		goblin.connect("canChangeHp", self, "updateHp")
		currentHp = false
	StoreHp.loadData()
	points = StoreHp.storedValue.totalPoints
	$HudSpawner/Hud/PlayerStatsContainer/Points.text = "Pontos: " + str(points)
