extends Node2D

signal touched
signal one_pipe_passed

export var pipesSpeed := 200
export var max_ecart := 250
export var min_ecart := 100
export var nb_spawing_point := 5
export var min_spawning_x = 300

var pipes = preload("res://twoPipe.tscn")
var spawningY = [] 
var spawningX = 0

var currentPipe


func _ready():
	var screenSize = get_viewport_rect().size
	var screenDiv = screenSize.y / (2 * (nb_spawing_point + 1))
	var noName1 = screenSize.y / 4
	
	spawningX = screenSize.x * 1.5
	for i in range(nb_spawing_point):
		spawningY.append(noName1 + i * screenDiv)
	start()

func _physics_process(delta):
	get_tree().call_group("pipeGroup", "move_and_slide", Vector2.LEFT * pipesSpeed)

func _process(delta):
	var distance = abs(spawningX - currentPipe.position.x)
	if distance >= min_spawning_x:
		create_new_pipe()

func create_new_pipe():
	var newPipes = pipes.instance()
	newPipes.init(Vector2(spawningX, spawningY[randi() % nb_spawing_point]), randi() % (max_ecart - min_ecart) + min_ecart)
	newPipes.connect("pipe_touched", self, "_on_one_pipe_touched")
	newPipes.connect("body_passed", self, "_on_one_pipe_passed")
	add_child(newPipes)
	
	currentPipe = newPipes

func _on_one_pipe_touched():
	emit_signal("touched")

func _on_one_pipe_passed():
	emit_signal("one_pipe_passed")

func _on_outArea_body_entered(body):
	emit_signal("touched")

func start():
	get_tree().call_group("pipeGroup", "queue_free")
	currentPipe = null
	create_new_pipe()
	set_process(true)
	set_physics_process(true)
	

func stop():
	set_process(false)
	set_physics_process(false)

