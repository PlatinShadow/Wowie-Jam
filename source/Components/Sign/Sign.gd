extends Node

onready var sFalse = $"Sign-False"
onready var sTrue = $"Sign-True"

func Enable():
	sFalse.visible = false
	sTrue.visible = true
	pass
	
func Disable():
	sFalse.visible = true
	sTrue.visible = false
	pass
