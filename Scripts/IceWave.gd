extends "res://Scripts/Projectile.gd"

onready var spellLife = get_node("SpellLife")

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	spellLife.start()
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		enemyArea.armor -= 4
		print("Vida do player: ", enemyArea.armor)
		queue_free()

func onSpellLifeTimeout():
	queue_free()
