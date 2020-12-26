extends TextureRect

var _changeScene

func onTryAgainPressed():
	_changeScene = get_tree().change_scene("res://Scenes/Main/Main.tscn")

func onQuitPressed():
	get_tree().quit()
