extends Control

onready var animator = get_node("Animator")
onready var dialogueLabel = get_node("DialogueContainer/DialogueLabel")
onready var buttonLabel = get_node("DialogueContainer/DialogueButton")

signal canClose

var dialogueCount = 0
var dialogueArray = ["...........", "Aaaaaaaah!!", "Droga, aquele velho me jogou aqui de novo", "...........", "Quem ele pensa que é?", "Esse ano eu vou mostrar pro mundo quem o Papai Noel é de verdade"]

func _ready():
	animator.play("BlinkAnimation")
	dialogueLabel.text = dialogueArray[dialogueCount]

func onNextButtonPressed():
	dialogueCount += 1
	if dialogueCount <= dialogueArray.size() - 1:
		dialogueLabel.text = dialogueArray[dialogueCount]
		if dialogueCount == dialogueArray.size() - 1:
			buttonLabel.text = "Fechar"
	else:
		$DialogueContainer.hide()
		emit_signal("canClose")
