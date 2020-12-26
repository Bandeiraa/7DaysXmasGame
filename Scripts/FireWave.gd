extends Area2D

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		enemyArea.armor -= 4
		queue_free()

func onSkillTimeout():
	queue_free()
