extends StaticBody

onready var tween = $Tween
onready var pad = $"jump-pad-0"

export var Impluse = Vector3(0, 50, 0)

func _ready():
	pass 


func _on_Trigger_body_entered(body):
	if body is KinematicBody and body.name == "Player":
		body.translation += Vector3(0,1,0)
		body.vel = Impluse
		body.isFlying = true
	else:
		body.linear_velocity = Vector3(0,0,0)
		body.apply_central_impulse(Impluse * 1.8)

	tween.interpolate_property(pad, "translation", pad.translation, Vector3(0,1,0), 0.8, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	tween.start()
	yield(get_tree().create_timer(1.0), "timeout")	
	tween.interpolate_property(pad, "translation", pad.translation, Vector3(0,0,0), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()	
	pass # Replace with function body.
