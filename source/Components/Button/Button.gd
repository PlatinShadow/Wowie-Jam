extends StaticBody

onready var animator	= $AnimationPlayer
onready var trigger 	= $Trigger
onready var light		= $OmniLight

signal button_pressed
signal button_released

func _ready():
	pass 


func _on_Trigger_area_entered(area):
	print("yeet")


func _on_Trigger_area_exited(area):
	pass # Replace with function body.


func _on_Trigger_body_entered(body):
	animator.play("Pressed")
	light.light_energy = 2
	emit_signal("button_pressed")
	print("button pressed")


func _on_Trigger_body_exited(body):
	animator.play("Default")
	light.light_energy = 1
	emit_signal("button_released")	
	print("button n ot")
