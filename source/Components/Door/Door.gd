extends Node

onready var anim = $AnimationPlayer

func Open(body = null):
	print("Door Opening")
	anim.play("Open")
	
func Close(body = null):
	print("Door Closing")
	anim.play("Close")
