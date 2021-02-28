extends Spatial

onready var ui = $ProgressUI
onready var door = $Map/Map/Door_Exit
onready var btn1 = $Map/Buttons/Button
onready var btn2 = $Map/Buttons/Button2


var progress = 0

func _ready():
	ui.SetProgress("0")
	ui.SetNumber("3")
	ui.SetTotal("5")
	ui.SetHint("Jump Pads")
	ui.PlayTitle()


func _on_IsCubeInPit_body_entered(body):
	progress += 1
	ui.SetProgress(str(progress))
	if progress == 5:
		ui.ShowGameDone()


func _on_IsPlayerInPit_body_entered(body):
	get_tree().change_scene("res://Levels/Chamber3.tscn")


func UpdateDoor():
	if btn1.isPressed == true and btn2.isPressed == true:
		door.Open()
	else:
		door.Close()
