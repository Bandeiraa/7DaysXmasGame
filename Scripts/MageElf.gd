extends "res://Scripts/Enemy.gd"

export var armor = 4 setget setArmor
var offset = Vector2()

func _ready():
	var _connection
	add_to_group("Enemy")
	chooseDirection()
	_connection = connect("area_entered", self, "areaEntered")
	#shoot()
	
func chooseDirection():
	randomize()
	var direction = ["left", "right"]
	var chooseDirection = direction[randi() % direction.size()]
	match chooseDirection:
		"left":
			velocity.x = velocity.x
		"right":
			velocity.x = -velocity.x
			
func _process(_delta):
	if get_position().x <= 0 + 16:
		velocity.x = abs(velocity.x)
	if get_position().x >= get_viewport_rect().size.x - 16:
		velocity.x = -abs(velocity.x)
		
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		enemyArea.armor -= 2
		
func setArmor(newValue):
	pass
