extends "res://Scripts/Projectile.gd"

onready var animator = get_node("Animator")
onready var damageLabel = get_node("DamageLabel")
onready var deathTimer = get_node("DeathTimer")

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	animator.play("FrostBolt")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		deathTimer.start()
		enemyArea.armor -= 3
		
func onDeathTimeout():
	queue_free()
