extends Node3D

const C = preload("res://constants.gd")
const MovementUtils = preload("res://shared.gd")

var pollux : Node3D
var left_aka : Node3D
var right_aka : Node3D
var main_propeller : Node3D
var side_propeller_1 : Node3D
var side_propeller_2 : Node3D

var velocity : Vector3 = Vector3.ZERO
var angular_velocity : float = 0.0

func _ready():
	pollux = $Pollux
	left_aka = $Pollux/Hull/LeftAka
	right_aka = $Pollux/Hull/RightAka

	main_propeller = $"Pollux/Hull/MidBody/Thruster/U92(ApisQueen)/Propeller001"
	side_propeller_1 = $"Pollux/Hull/MidBody/Thruster/U2(ApisQueen)_Fore/Propeller001001"
	side_propeller_2 = $"Pollux/Hull/MidBody/Thruster/U2(ApisQueen)_After/Propeller0010012"

func _process(delta):
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_down"):
		input_dir.z -= 1
	if Input.is_action_pressed("ui_up"):
		input_dir.z += 1

	velocity = MovementUtils.handle_translation(pollux, velocity, input_dir, delta, C)

	var target_rot_speed : float = 0.0
	if Input.is_action_pressed("ui_left"):
		target_rot_speed = C.MAX_ROT_SPEED
	elif Input.is_action_pressed("ui_right"):
		target_rot_speed = -C.MAX_ROT_SPEED

	angular_velocity = MovementUtils.handle_rotation(pollux, angular_velocity, target_rot_speed, delta, C)
	MovementUtils.handle_propellers(main_propeller, side_propeller_1, side_propeller_2,
								velocity, angular_velocity, delta, C)
