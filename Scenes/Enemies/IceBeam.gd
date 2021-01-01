extends "res://Scripts/Projectile.gd"

func _ready():
	add_to_group("IceSpear")
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		enemyArea.armor -= 1
		queue_free()
