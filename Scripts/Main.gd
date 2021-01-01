extends Node2D

var loadGoblin = preload("res://Scenes/Character/Goblin.tscn")
var loadText = preload("res://Scenes/Interface/Dialogue.tscn")
var loadEnemy = preload("res://Scenes/Enemies/EnemySpawner.tscn")
var loadSanta = preload("res://Scenes/Enemies/Santa.tscn")
var playerHUD = preload("res://Scenes/Interface/Hud.tscn")
var goblin; var points = 0; var auxKey = false

onready var goblinSpawner = get_node("GoblinSpawner")
onready var dialogueSpawner = get_node("DialogueSpawner")
onready var enemySpawner = get_node("EnemySpawner")
onready var hudSpawner = get_node("HudSpawner")
onready var animator = get_node("DamageAnimation")
onready var snowFall = get_node("SnowAnimator")
onready var snowFallAux = get_node("SnowAnimatorAux")
onready var santaSpawner = get_node("SantaSpawner")

var spawnCurrentPosition
var key = false
var currentFrame = 0
var spawnKey = false
var currentHp = false
var santa
var enemies
var label
signal canSpawn
signal canCallSantaClaus
signal thirdDialogue
signal canLevelUp

export(int) var yDistanceOffset = 67
export(int) var velocityOffset = 70

func _ready():
	GlobalAudioStreamPlayer.play()
	snowFall.play("SnowAnimation")
	snowFallAux.play("SnowFall")
	label = loadText.instance()
	var hud = playerHUD.instance()
	hudSpawner.add_child(hud)
	dialogueSpawner.add_child(label)
	spawnCurrentPosition = goblinSpawner.get_position()
	label.connect("canClose", self, "canCall")
	StoreHp.storedValue.canCallText = false
	StoreHp.storedValue.canLevelUp = false
	StoreHp.storedValue.canCallSantaAgain = false
	StoreHp.storedValue.totalPoints = 0
	StoreHp.storedValue.currentLevel = 1
	StoreHp.save()
	
func canSpawn():
	enemies = loadEnemy.instance()
	enemySpawner.add_child(enemies)
	
func canCall():
	goblin = loadGoblin.instance()
	goblinSpawner.add_child(goblin)
	key = true
	
func updateHp():
	currentFrame += 1
	StoreHp.loadData()
	if currentFrame <= 8:
		$HudSpawner/Hud/PlayerStatsContainer/HealthSprite.set_frame(currentFrame)
	animator.play("Damage")
	currentHp = false
	
func canCallSantaClaus():
	StoreHp.storedValue.canCallSanta = true
	StoreHp.save()
	label = loadText.instance()
	dialogueSpawner.add_child(label)
	label.connect("canCloseAndCallSanta", self, "canSummonSanta")
	
func canSummonSanta():
	santa = loadSanta.instance()
	santaSpawner.add_child(santa)
	StoreHp.loadData()

func onFinishLevel():
	StoreHp.storedValue.canCallSanta = false
	StoreHp.storedValue.canCallText = true
	StoreHp.save()
	print("Finalizou")
	label = loadText.instance()
	dialogueSpawner.add_child(label)

func onLevelUp():
	enemies = loadEnemy.instance()
	enemySpawner.add_child(enemies)
	key = false
	StoreHp.storedValue.currentLevel += 1
	print("Nivel atual: ", StoreHp.storedValue.currentLevel)
	
func _process(delta):
	if key == true:
		spawnCurrentPosition.y -= delta * velocityOffset
		var viewSize = get_viewport_rect().size
		if spawnCurrentPosition.y >= viewSize.y - yDistanceOffset:
			$GoblinSpawner/Goblin/KinematicBody/WalkAnimation.play("RightAnim")
			goblinSpawner.position.y = spawnCurrentPosition.y
			spawnKey = true
		elif spawnKey == true:
			emit_signal("canSpawn")
			spawnKey = false
			currentHp = true
			key = false
	if currentHp:
		goblin.connect("canChangeHp", self, "updateHp")
		currentHp = false
	StoreHp.loadData()
	points = StoreHp.storedValue.totalPoints
	$HudSpawner/Hud/PlayerStatsContainer/Points.text = str(points)
	if points >= 500 * StoreHp.storedValue.currentLevel and key == false:
		dialogueSpawner.remove_child(label)
		enemySpawner.remove_child(enemies)
		print("500 pontos !!!")
		emit_signal("canCallSantaClaus")
		key = true
	if StoreHp.storedValue.canCallText == true and auxKey == false:
		dialogueSpawner.remove_child(label)
		emit_signal("thirdDialogue")
		print("Deu bom")
		auxKey = true
	if StoreHp.storedValue.canLevelUp == true:
		emit_signal("canLevelUp")
		StoreHp.storedValue.canLevelUp = false
		StoreHp.save()
	if StoreHp.storedValue.canCallSantaAgain == true:
		auxKey = false
		StoreHp.storedValue.canCallSantaAgain = false
		StoreHp.save()
