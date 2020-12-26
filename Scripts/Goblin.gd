extends KinematicBody2D

export (int) var speed = 50
onready var shootTimer = get_node("ShootCooldown")

var goblinProjectile = preload("res://Scenes/Character/GoblinProjectile.tscn")
var velocity = Vector2()
var _reload; var _changeScene

func _ready():
	shoot()
	
func shoot():
	var cannon = get_node("CannonSpawner")
	createProjectile(cannon)
	shootTimer.start()
		
func createProjectile(position):
	var projectile = goblinProjectile.instance()
	position.add_child(projectile)  
		
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
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
