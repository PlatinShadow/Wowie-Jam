extends Spatial


func _on_Area_body_entered(body):
	body.isFlying = false