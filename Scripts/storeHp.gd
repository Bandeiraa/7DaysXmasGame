extends Node

const FILE_NAME = "user://game-data.json"

var storedValue = {
	"currentHp": 0,
	"totalPoints": 1,
	"canCallSanta": false,
	"canCallText": false,
	"canLevelUp": false,
	"canCallSantaAgain": false,
	"currentLevel:": 1
}

func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(storedValue))
	file.close()
	
func loadData():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			storedValue = data
		else:
			printerr("Error")
	else:
		printerr("No saved data!")
