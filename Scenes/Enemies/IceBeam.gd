extends "res://Scripts/Projectile.gd"

onready var animator = get_node("Animator")
onready var damageLabel = get_node("DamageLabel")
onready var deathTimer = get_node("DeathTimer")

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		deathTimer.start()
		enemyArea.armor -= 3
		animator.play("DamageDealth")
		damageLabel.text = str(-3)
		velocity.y = 0
		velocity.x = 0
		$Projectile.hide()
		#print("Vida do player: ", enemyArea.armor)
		
func onDeathTimeout():
	queue_free()
