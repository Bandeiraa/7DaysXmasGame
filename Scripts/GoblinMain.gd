extends Node2D

signal canChangeHp

func canGetValue():
	emit_signal("canChangeHp")
