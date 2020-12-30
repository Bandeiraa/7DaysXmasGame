extends Area2D

export(int) var armor = 20 setget setArmor
signal canQueueFree; signal canGetValue; signal canSlowDown

func _ready():
	add_to_group("Goblin")
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	StoreHp.storedValue.currentHp = armor
	StoreHp.save()
	
func setArmor(newValue):
	armor = newValue
	StoreHp.storedValue.currentHp = armor
	StoreHp.save()
	emit_signal("canGetValue")
	if armor <= 0:
		StoreHp.storedValue.currentHp = 0
		StoreHp.save()
		emit_signal("canGetValue")
		emit_signal("canQueueFree")
		
func areaEntered(enemyArea):
	if enemyArea.is_in_group("IceSpear"):
		emit_signal("canSlowDown")
	elif enemyArea.is_in_group("LancerSpear"):
		$BleedTimer.start()

func onBleedTimeout():
	armor -= 2
	StoreHp.storedValue.currentHp = armor
	StoreHp.save()
	emit_signal("canGetValue")
	print("Sangramento!! vida atual: ", armor)
