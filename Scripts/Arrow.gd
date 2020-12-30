extends "res://Scripts/Projectile.gd"

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		enemyArea.armor -= 2
		queue_free()
