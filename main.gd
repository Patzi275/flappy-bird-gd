extends Node2D

var score = 0

func _ready():
	$obstacles.stop()
	$Bird.stop()
	$Ui.setScore(0)

func _process(delta):
	if not $Ui.visible:
		$ParallaxBackground/ParallaxLayer.motion_offset.x -= delta * 40

func _on_obstacles_touched():
	
	$Bird.stop()
	$obstacles.stop()
	$Ui.setScore(score)
	$AudioStreamPlayer.play()
	$Ui.visible = true

func _on_Ui_start_game():
	$ParallaxBackground/ParallaxLayer.motion_offset.x = 0
	update_score(0)
	$obstacles.start()
	$Bird.start()
	$Ui.visible = false

func _on_obstacles_one_pipe_passed():
	update_score(score + 1)
	print("passed")

func update_score(sc : int):
	score = sc
	$gameUi/HBoxContainer/Label.text = "Score " + str(score)
