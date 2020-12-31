extends Control

onready var animator = get_node("Animator")
onready var dialogueLabel = get_node("DialogueContainer/DialogueLabel")
onready var buttonLabel = get_node("DialogueContainer/DialogueButton")

signal canClose
signal canCloseAndCallSanta

var key = false; var keyAux = false; var keyEnd = false
var dialogueCount = 0
var dialogueArray = ["...........", "Aaaaaaaah!!", "Droga, aquele velho me jogou aqui de novo", "...........", "Quem ele pensa que é?", "Esse ano eu vou mostrar pro mundo quem o Papai Noel é de verdade!!!"]
var santaClausDialogueArray = ["...........", "Você não se cansa, hein ?", "Pare de tentar fugir, e aceite o seu destino como meu ajudante", "Acho que vou ter que te dar uma lição!"]
var endingDialogue = ["Aaaaargh", "...........", "Voltarei mais tarde para nós continuarmos isso"]

func _ready():
	animator.play("BlinkAnimation")
	StoreHp.loadData()
	print(StoreHp.storedValue.canCallSanta)
	if StoreHp.storedValue.canCallSanta == true:
		print("Aqui")
		dialogueLabel.text = santaClausDialogueArray[dialogueCount]
	elif StoreHp.storedValue.canCallText == true:
		print("Texto aqui ó")
		dialogueLabel.text = endingDialogue[dialogueCount]
	else:
		print("Entrou no else")
		dialogueLabel.text = dialogueArray[dialogueCount]

func onNextButtonPressed():
	dialogueCount += 1
	if StoreHp.storedValue.canCallSanta == true and keyAux == false:
		if dialogueCount <= santaClausDialogueArray.size() - 1: 
			dialogueLabel.text = santaClausDialogueArray[dialogueCount]
			if dialogueCount == santaClausDialogueArray.size() - 1:
				buttonLabel.text = "Fechar"
				keyAux = true
				StoreHp.storedValue.canCallSanta = false
				StoreHp.save()
				
	elif StoreHp.storedValue.canCallText == true:
		if dialogueCount <= endingDialogue.size() - 1:
			dialogueLabel.text = endingDialogue[dialogueCount]
			if dialogueCount == endingDialogue.size() - 1:
				buttonLabel.text = "Fechar"
				keyEnd = true
			
	elif dialogueCount <= dialogueArray.size() and key == false:
		dialogueLabel.text = dialogueArray[dialogueCount]
		if dialogueCount == dialogueArray.size() - 1:
			buttonLabel.text = "Fechar"
			StoreHp.storedValue.canCallSanta = false
			StoreHp.save()
			print(dialogueCount)
			print(dialogueArray.size())
			key = true
			
	if keyEnd == true:
		if buttonLabel.text == "Fechar" and dialogueCount == endingDialogue.size():
			$DialogueContainer.hide()
			StoreHp.storedValue.canLevelUp = true
			StoreHp.save()
			pass

	if key == true:
		if buttonLabel.text == "Fechar" and dialogueCount == dialogueArray.size():
			$DialogueContainer.hide()
			emit_signal("canClose")
			
	if keyAux == true:
		if buttonLabel.text == "Fechar" and dialogueCount == santaClausDialogueArray.size():
			$DialogueContainer.hide()
			emit_signal("canCloseAndCallSanta")
