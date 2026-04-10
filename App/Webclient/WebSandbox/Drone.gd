extends Node3D

# ---- drone ----
var RearBody : Node3D
var ForeBody : Node3D
var MidBody : Node3D
var Aka_Left : Node3D
var Aka_Right : Node3D
var ActiveJoint : int = 1

# ---- camera ----
var Camera1 : Camera3D
var Camera2 : Camera3D
var ActiveCamera : int = -999

# ---- kinetics ----
var TranslationSpeed : float = 0.05
var RotationSpeed : float = 90.0

func _ready():
	print("Drone is ready!")

	# Get child nodes by name
	Aka_Left = $Aka_Left
	Aka_Right = $Aka_Right
	Camera1 = $Camera3D_Fixed1
	Camera2 = $Camera3D_Fixed2


func _process(delta):
	var direction = Vector3.ZERO

	# Camera selection input
	if Input.is_action_pressed("ui_f1"):
		ActiveCamera = 1
		print("Camera one selected")

	if Input.is_action_pressed("ui_f2"):
		ActiveCamera = 2
		print("Camera two selected")

	# Joint switch
	if Input.is_action_pressed("ui_number_one"):
		ActiveJoint = 1
		print("Joint one selected")

	if Input.is_action_pressed("ui_number_two"):
		ActiveJoint = 2
		print("Joint two selected!")

	# Rotation controls
	if Input.is_action_pressed("ui_right"):
		if ActiveJoint == 1:
			Aka_Left.rotate_z(deg_to_rad(-RotationSpeed) * delta)
			Aka_Right.rotate_z(deg_to_rad(RotationSpeed) * delta)

	if Input.is_action_pressed("ui_left"):
		if ActiveJoint == 1:
			Aka_Left.rotate_z(deg_to_rad(RotationSpeed) * delta)
			Aka_Right.rotate_z(deg_to_rad(-RotationSpeed) * delta)

	if Input.is_action_pressed("ui_up"):
		pass

	if Input.is_action_pressed("ui_down"):
		pass

	# Camera switch
	if ActiveCamera == 1:
		Camera1.make_current()
	elif ActiveCamera == 2:
		Camera2.make_current()

	# Normalize so diagonal movement isn’t faster
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	# Apply translation movement
	position += direction * TranslationSpeed * delta
