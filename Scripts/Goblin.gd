extends KinematicBody2D

export (int) var speed = 50
onready var shootTimer = get_node("ShootCooldown")
onready var walkAnimation = get_node("WalkAnimation")
onready var firstShoot = get_node("FirstShootDelay")
onready var slowDown = get_node("SlowDownTimer")
onready var damageTaken = get_node("DamageAnimation")

var goblinProjectile = preload("res://Scenes/Character/GoblinProjectile.tscn")
var velocity = Vector2()
var _reload; var _changeScene
var callsCount; var auxCount = 0

func _ready():
	firstShoot.start()
	
func shoot():
	var projectile = goblinProjectile.instance() 
	projectile.set_position(get_global_position())
	get_tree().get_root().call_deferred("add_child", projectile) 
	shootTimer.start()

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		walkAnimation.play("RightAnim")
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		walkAnimation.play("LeftAnim")
		velocity.x -= 1
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	var viewSize = get_viewport_rect().size
	var pos = get_position()
	pos.x = clamp(pos.x, 0 - 57, viewSize.x - 87)
	set_position(pos)
	get_input()
	velocity = move_and_slide(velocity)
	
func canDestroy():
	_changeScene = get_tree().change_scene("res://Scenes/Interface/GameOver.tscn")

func onShootTimeout():
	shoot()

func onFirstShootTimeout():
	shoot()

func onSlowDown():
	auxCount += 1 
	callsCount = auxCount
	speed = speed/1.4
	slowDown.start()
	print(speed)
	
func onSlowDownTimeout():
	speed = speed * pow(1.4, callsCount)
	print(speed)
	auxCount = 0 

