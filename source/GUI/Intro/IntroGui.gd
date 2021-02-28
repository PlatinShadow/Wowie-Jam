extends Node

onready var popup = $Panel/PopupDialog

func _on_Button_Accept():
	get_tree().change_scene("res://Levels/Testing.tscn")


func _on_Button2_Reject():
	popup.popup()
