extends "res://Scripts/Projectile.gd"

func _ready():
	var _connection
	_connection = connect("area_entered", self, "areaEntered")
	
func areaEntered(enemyArea):
	if enemyArea.is_in_group("Enemy"):
		CameraShake.shake(1, 0.1)
		enemyArea.armor -= 3
		queue_free()
		
func _process(_delta):
	if get_position().y <= get_viewport_rect().size.y - 260:
		queue_free()
