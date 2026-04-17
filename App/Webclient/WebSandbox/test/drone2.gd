extends Node3D

const C = preload("res://constants.gd")

var pollux : Node3D
var left_aka : Node3D
var right_aka : Node3D

var velocity : Vector3 = Vector3.ZERO 	#linear translation
var angular_velocity : float = 0.0		#rotational movement

func _ready():
	pollux = $Pollux
	left_aka = $Pollux/Pollux_ver8/Hull/LeftAka
	right_aka = $Pollux/Pollux_ver8/Hull/RightAka

func _process(delta):
	handle_translation(delta)
	handle_rotation(delta)

func handle_translation(delta):
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("ui_down"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z += 1

	input_dir = input_dir.normalized()

	if input_dir != Vector3.ZERO:
		velocity = velocity.move_toward(input_dir * C.MAX_SPEED, C.ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, C.DECELERATION * delta)

	pollux.translate(velocity * delta)

func handle_rotation(delta):
	var target_rot_speed : float = 0.0

	if Input.is_action_pressed("ui_left"):
		target_rot_speed = C.MAX_ROT_SPEED
	elif Input.is_action_pressed("ui_right"):
		target_rot_speed = -C.MAX_ROT_SPEED

	# Accelerate or decelerate angular velocity
	if target_rot_speed != 0.0:
		angular_velocity = move_toward(angular_velocity, target_rot_speed, C.ROT_ACCELERATION * delta)
	else:
		angular_velocity = move_toward(angular_velocity, 0.0, C.ROT_DECELERATION * delta)

	# Apply rotation
	pollux.rotate_y(deg_to_rad(angular_velocity) * delta)
