extends TextureRect

var _changeScene
onready var totalPoints = get_node("TotalPoints")

func _ready():
	StoreHp.loadData()
	var points = StoreHp.storedValue.totalPoints
	totalPoints.text = str(points) + " pontos"

func onTryAgainPressed():
	_changeScene = get_tree().change_scene("res://Scenes/Main/Main.tscn")

func onQuitPressed():
	get_tree().quit()
