extends Control

signal start_game
signal exit_game

var finalScore = 0

func _on_Button2_pressed():
	emit_signal("start_game")

func _on_Button3_pressed():
	emit_signal("exit_game")

func setScore(score : int):
	$VBoxContainer/MarginContainer/Panel/Label.text = str(score)
