extends KinematicBody2D

export (int) var speed = 50
onready var shootTimer = get_node("ShootCooldown")

var goblinProjectile = preload("res://Scenes/Character/GoblinProjectile.tscn")
onready var walkAnimation = get_node("WalkAnimation")
var velocity = Vector2()
var _reload; var _changeScene
signal canChangeHp

func _ready():
	shoot()
	
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
	if Input.is_action_pressed('ui_left'):
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
	$ChangeSceneCooldown.start()
	
func onShootTimeout():
	shoot()

func onTimerCooldown():
	_changeScene = get_tree().change_scene("res://Scenes/Interface/GameOver.tscn")

func canGetValue():
	emit_signal("canChangeHp")
