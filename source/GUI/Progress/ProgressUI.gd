extends Node

onready var prog = $Panel/Progress
onready var num  = $Panel/Number
onready var done = $Panel/Done
onready var title = $"Chamber Title"
onready var anim = $AnimationPlayer
onready var pannel = $Panel
onready var doneMsg = $"Done Message"
onready var audio = $AudioStreamPlayer
onready var hint = $Hint
onready var gamedone1 = $GameDoneMSG1
onready var gamedone2 = $GameDoneMSG2


var total = "1"

func _ready():
	pannel.visible = false
	done.visible = false
	doneMsg.visible = false
	gamedone1.visible = false
	gamedone2.visible = false
	

func _input(event):
	if event.is_action_pressed("progress"):
		pannel.visible = true
	if event.is_action_released("progress"):
		pannel.visible = false
	
func SetHint(hinttext):
	hint.text = hinttext
			
func ShowGameDone():
	pannel.visible = true
	gamedone1.visible = true
	gamedone2.visible = true
	audio.play(0)
			
func ShowDone():
	pannel.visible = true
	done.visible = true
	doneMsg.visible = true
	audio.play(0)

func SetTotal(tot):
	total = tot
	prog.text = "0/" + total

func SetProgress(newProg):
	prog.text = newProg + "/" + total

func SetNumber(text):
	num.text = text
	title.text = "Chamber " + text
	
func PlayTitle():
	title.visible = true
	anim.play("Fade")
