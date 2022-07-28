extends RigidBody2D

export var impulse = 600
var initial_position : Vector2

func _ready():
	initial_position = global_position
	set_physics_process(false)
	start()

func _process(delta):
	if linear_velocity.y > 0:
		$bird.set_animation("noMove")
	else:
		if $bird.get_animation() == "noMove":
			$bird.set_animation("flying")

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		set_linear_velocity(Vector2.ZERO)
		apply_central_impulse(Vector2.UP * 800)
		global_rotation_degrees = -30
	if global_rotation_degrees <= 60:
		global_rotation_degrees += 120 * delta

func start():
	$bird.animation = "flying"
	position = initial_position
	linear_velocity = Vector2.ZERO
	gravity_scale = 25.37
	global_rotation_degrees = -30
	#apply_central_impulse(Vector2.UP * 800)
	set_process(true)
	set_physics_process(true)

func stop():
	$bird.animation = "noMove"
	linear_velocity = Vector2.ZERO
	gravity_scale = 0
	set_physics_process(false)
	set_process(false)
