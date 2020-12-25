extends Area2D

var armor = 10 setget setArmor
signal canQueueFree

func _ready():
	add_to_group("Goblin")
	
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		emit_signal("canQueueFree")
