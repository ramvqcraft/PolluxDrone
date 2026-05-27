extends Node3D

const C = preload("res://constants.gd")
const MovementUtils = preload("res://shared.gd")

var tom : Node3D
var velocity : Vector3 = Vector3.ZERO

# Arm references
@export var left_arm_path : NodePath
@export var right_arm_path : NodePath
var left_arm : Node3D
var right_arm : Node3D

# Leg references
@export var left_leg_path : NodePath
@export var right_leg_path : NodePath
var left_leg : Node3D
var right_leg : Node3D

var time : float = 0.0

# Swim parameters
@export var swim_speed : float = 2.0
@export var arm_angle : float = 45.0
@export var leg_angle : float = 25.0

func _ready():
	tom = get_node("/root/Node3D/Tom")
	left_arm = $"Human/LA"
	right_arm = $"Human/RA"
	left_leg = $"Human/LL"
	right_leg = $"Human/RL"

func _process(delta):
	# Handle translation
	var input_dir = Vector3.ZERO
	if Input.is_action_pressed("ui_a"):
		input_dir.x -= 1
	if Input.is_action_pressed("ui_z"):
		input_dir.x += 1

	velocity = MovementUtils.handle_translation(tom, velocity, input_dir, delta, C)

	# Handle swimming arms
	time += delta * swim_speed
	var left_arm_angle = sin(time) * deg_to_rad(arm_angle)
	var right_arm_angle = sin(time + PI) * deg_to_rad(arm_angle) # phase shift

	left_arm.rotation.z = left_arm_angle
	right_arm.rotation.z = right_arm_angle

	# Handle leg kicks (alternate phase)
	var left_leg_angle = sin(time + PI/2) * deg_to_rad(leg_angle)
	var right_leg_angle = sin(time + 3*PI/2) * deg_to_rad(leg_angle)

	left_leg.rotation.z = left_leg_angle
	right_leg.rotation.z = right_leg_angle
