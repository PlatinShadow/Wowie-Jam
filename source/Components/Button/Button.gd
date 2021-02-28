extends StaticBody

onready var animator	= $AnimationPlayer
onready var trigger 	= $Trigger
onready var light		= $OmniLight

signal button_pressed
signal button_released

var isPressed = false
var lastActionTime = 0
var lastActionTime1 = 0


const DELAY = 100

func _ready():
	pass 


func _on_Trigger_area_entered(area):
	print("yeet")


func _on_Trigger_area_exited(area):
	pass # Replace with function body.


func _on_Trigger_body_entered(body):
	var currentActionTime = OS.get_ticks_msec()
	var time = currentActionTime - lastActionTime
	isPressed = true
	
	if time > DELAY:
		lastActionTime = currentActionTime
		animator.play("Pressed")
		light.light_energy = 2
		emit_signal("button_pressed")
		print("button pressed")


func _on_Trigger_body_exited(body):
	var currentActionTime = OS.get_ticks_msec()
	var time = currentActionTime - lastActionTime
	isPressed = false
	
	if time > DELAY:
		lastActionTime = currentActionTime
		animator.play("Default")
		light.light_energy = 1
		emit_signal("button_released")
		print("button n ot")
