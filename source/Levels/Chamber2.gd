extends Spatial

onready var ui = $ProgressUI
onready var btn_door_1 = $Map/Button
onready var btn_door_2 = $Map/Button2
onready var door_exit = $Map/Door_Exit

onready var btn_bridge = $Map/Button_Bridge_1
onready var tween_bridge = $Map/Bridge/Tween
onready var bridge = $Map/Bridge/Bridge

onready var player = $Player

var progress = 0

func _ready():
	ui.SetProgress("0")
	ui.SetNumber("2")
	ui.SetTotal("2")
	ui.SetHint("The Pit")
	ui.PlayTitle()

func UpdateDoor():
	if btn_door_1.isPressed == true and btn_door_2.isPressed == true:
		door_exit.Open()
	else:
		door_exit.Close()
	
func _on_IsCubeInPit_body_entered(body):
	progress += 1
	ui.SetProgress(str(progress))
	if progress == 2:
		ui.ShowDone()
		yield(get_tree().create_timer(10.0), "timeout")	
		get_tree().change_scene("res://Levels/Chamber3.tscn")

func UpdateBridge():
	if btn_bridge.isPressed == true:
		tween_bridge.interpolate_property(bridge, "translation", bridge.translation, Vector3(10,0,0), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween_bridge.start()
	else:
		tween_bridge.interpolate_property(bridge, "translation", bridge.translation, Vector3(0,0,0), 1, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		tween_bridge.start()

func UpdateCubeChamberStuck(body = null):
	if btn_bridge.isPressed == false and player.translation.y < 12:
		yield(get_tree().create_timer(4.0), "timeout")
		ui.ShowDone()
		yield(get_tree().create_timer(10.0), "timeout")	
		get_tree().change_scene("res://Levels/Chamber3.tscn")

func _on_IsPlayerInPit_body_entered(body):
	get_tree().change_scene("res://Levels/Chamber2.tscn")
