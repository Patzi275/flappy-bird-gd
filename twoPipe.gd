extends KinematicBody2D

signal pipe_touched
signal body_passed

func init(pos : Vector2, distance_between : int):
	position = pos
	$topPipe.position.y -= distance_between / 2
	$downPipe.position.y += distance_between / 2


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_topPipe_body_entered(body):
	emit_signal("pipe_touched")

func _on_downPipe_body_entered(body):
	emit_signal("pipe_touched")

func _on_outerArea_body_exited(body):
	emit_signal("body_passed")
