extends Node

onready var ui = $ProgressUI
onready var door = $Map/Door_Exit
onready var cube = $Map/Cube

var isCubeOutside = false
var isDone = false

var progress = 0
const BUGS = 1

func _ready():
	ui.SetProgress("0")
	ui.SetNumber("1")
	ui.SetTotal("1")
	ui.PlayTitle()

func _process(delta):
	if isDone == false and door.isOpen == false and isCubeOutside == true:
		ui.ShowDone()
		isDone = true
		yield(get_tree().create_timer(10.0), "timeout")
		get_tree().change_scene("res://Levels/Chamber2.tscn")

func _on_IsCubeOutside_body_entered(body):
	isCubeOutside = true
	progress += 1
	ui.SetProgress(str(progress))	
	print("Cube is outside")


func _on_IsCubeOutside_body_exited(body):
	isCubeOutside = false
	progress -= 1
	ui.SetProgress(str(progress))
	print("Cube is in chamber")


func _on_IsCubeBugged_body_entered(body):
	var newTrans = Transform.IDENTITY
	newTrans.origin.y += 3
	cube.set_global_transform(newTrans)
