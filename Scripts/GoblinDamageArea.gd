extends Area2D

var armor = 10 setget setArmor
onready var healthLabel = get_node("HealthLabel")
onready var animator = get_node("Animator")

signal canQueueFree

func _ready():
	healthLabel.text = ("Vida: " + str(armor))
	add_to_group("Goblin")
	
func setArmor(newValue):
	armor = newValue
	animator.play("minosHealth")
	healthLabel.text = ("Vida: " + str(armor))
	if armor <= 0:
		animator.play("minosHealth")
		healthLabel.text = "Vida: 0"
		emit_signal("canQueueFree")
