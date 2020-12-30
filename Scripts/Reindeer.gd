extends Area2D

export var velocity = Vector2()
export var armor = 5 setget setArmor
var storedHp = 0

func _ready():
	var _connect
	add_to_group("Enemy")
	set_process(true)
	_connect = connect("area_entered", self, "areaEntered")
	
func _process(delta):
	translate(velocity * delta)
	if get_position().y >= get_viewport_rect().size.y + 60:
		queue_free()
		
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Goblin"):
		StoreHp.loadData()
		storedHp = StoreHp.storedValue.currentHp
		enemyArea.armor -= storedHp
		print("Vida do player: ", enemyArea.armor)
		
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		StoreHp.storedValue.totalPoints += int(rand_range(5, 15))
		StoreHp.save()
		queue_free()
