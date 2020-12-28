extends Area2D

export(int) var armor = 10 setget setArmor
signal canQueueFree; signal canGetValue

func _ready():
	add_to_group("Goblin")
	
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
