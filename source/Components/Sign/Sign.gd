extends Node

onready var sFalse = $"Sign-False"
onready var sTrue = $"Sign-True"

var isActive = false

func Enable():
	sFalse.visible = false
	sTrue.visible = true
	isActive = true
	pass
	
func Disable():
	sFalse.visible = true
	sTrue.visible = false
	isActive = false
	pass
