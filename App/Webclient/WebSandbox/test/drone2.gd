extends Node3D

# References to parts
var Pollux : Node3D
var left_aka : Node3D
var right_aka : Node3D

# Movement parameters
var translation_speed : float = 2.0
var rotation_speed : float = 90.0

func _ready():
	# Pollux is a direct child of the root Node3D
	Pollux = $Pollux
	
	# From Pollux, drill down into Pollux_ver8 → Hull → LeftAka/RightAka
	left_aka = $Pollux/Pollux_ver8/Hull/LeftAka
	right_aka = $Pollux/Pollux_ver8/Hull/RightAka


func _process(delta):
	var move_dir = Vector3.ZERO

	# --- Drone translation ---
	if Input.is_action_pressed("ui_up"):
		move_dir.z -= 1
	if Input.is_action_pressed("ui_down"):
		move_dir.z += 1
	if Input.is_action_pressed("ui_left"):
		move_dir.x -= 1
	if Input.is_action_pressed("ui_right"):
		move_dir.x += 1

	if move_dir != Vector3.ZERO:
		move_dir = move_dir.normalized()
		Pollux.translate(move_dir * translation_speed * delta)

	# --- Aka rotation ---
	#if Input.is_action_pressed("rotate_aka_left"):
		#left_aka.rotate_z(deg_to_rad(rotation_speed) * delta)
		#right_aka.rotate_z(deg_to_rad(-rotation_speed) * delta)

	#if Input.is_action_pressed("rotate_aka_right"):
		#left_aka.rotate_z(deg_to_rad(-rotation_speed) * delta)
		#right_aka.rotate_z(deg_to_rad(rotation_speed) * delta)
