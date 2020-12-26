extends "res://Scripts/Projectile.gd"

onready var animator = get_node("Animator")
onready var damageLabel = get_node("DamageLabel")
onready var deathTimer = get_node("DeathTimer")

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Enemy"):
		deathTimer.start()
		enemyArea.armor -= 1
		animator.play("damageDealth")
		damageLabel.text = str(-1)
		velocity.y = 0
		$Projectile.hide()
		
func onDeathTimeout():
	queue_free()
