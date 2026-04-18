extends Node3D

const C = preload("res://constants.gd")

var pollux : Node3D
var left_aka : Node3D
var right_aka : Node3D
var main_propeller : Node3D
var side_propeller_1 : Node3D
var side_propeller_2 : Node3D

var velocity : Vector3 = Vector3.ZERO 	#linear translation
var angular_velocity : float = 0.0		#rotational movement

func _ready():
	
	# loading drone hierarchy
	pollux = $Pollux
	left_aka = $Pollux/Hull/LeftAka
	right_aka = $Pollux/Hull/RightAka

	main_propeller = $"Pollux/Hull/MidBody/Thruster/U92(ApisQueen)/Propeller001"
	side_propeller_1 = $"Pollux/Hull/MidBody/Thruster/U2(ApisQueen)_Fore/Propeller001001"
	side_propeller_2 = $"Pollux/Hull/MidBody/Thruster/U2(ApisQueen)_After/Propeller0010012"



func _process(delta):
	handle_translation(delta)
	handle_rotation(delta)
	handle_propellers(delta)

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
	
func handle_propellers(delta):
	# Spin main propeller based on forward/backward velocity
	var main_spin = velocity.length() * C.MAIN_PROPELLER_SPIN
	main_propeller.rotate_z(deg_to_rad(main_spin) * delta)

	# Spin side propellers based on angular velocity
	var side_spin = abs(angular_velocity) * C.SIDE_PROPELLER_SPIN
	side_propeller_1.rotate_z(deg_to_rad(side_spin) * delta)
	side_propeller_2.rotate_z(deg_to_rad(side_spin) * delta)	
