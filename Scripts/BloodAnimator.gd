extends Node2D

onready var animator = get_node("AnimationPlayer")

func _ready():
	animator.play("BloodLifetime")
	
func canQueueFree():
	queue_free()
