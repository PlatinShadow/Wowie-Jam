extends Node

onready var tween = $Tween
onready var door = $StaticBody

var isOpen = false

func Open(body = null):
	print("Door Opening")
	tween.interpolate_property(door, "translation", door.translation, Vector3(0,4.5,0), 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	isOpen = true
	
func Close(body = null):
	print("Door Closing")
	tween.interpolate_property(door, "translation", door.translation, Vector3(0,0,0), 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()
	isOpen = false
