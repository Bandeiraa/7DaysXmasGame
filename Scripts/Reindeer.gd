extends Area2D

export var velocity = Vector2()
export var armor = 5 setget setArmor
onready var labelAnimation = get_node("Animator")
onready var damageLabel = get_node("DamageLabel")

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
		enemyArea.armor -= 100000000
		labelAnimation.play("DamageAnimation")
		damageLabel.text = str(100000000)
		velocity.y = 0
		$EnemySprite.hide()
		print("Vida do player: ", enemyArea.armor)
		
func setArmor(newValue):
	armor = newValue
	if armor <= 0:
		queue_free()
