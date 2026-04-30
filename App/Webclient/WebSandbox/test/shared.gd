# shared.gd
extends Resource

# Shared translation function
static func handle_translation(pollux: Node3D, velocity: Vector3, input_dir: Vector3, delta: float, C) -> Vector3:
	input_dir = input_dir.normalized()
	if input_dir != Vector3.ZERO:
		velocity = velocity.move_toward(input_dir * C.MAX_SPEED, C.ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, C.DECELERATION * delta)

	pollux.translate(velocity * delta)
	return velocity

# Shared rotation function
static func handle_rotation(pollux: Node3D, angular_velocity: float, target_rot_speed: float, delta: float, C) -> float:
	if target_rot_speed != 0.0:
		angular_velocity = move_toward(angular_velocity, target_rot_speed, C.ROT_ACCELERATION * delta)
	else:
		angular_velocity = move_toward(angular_velocity, 0.0, C.ROT_DECELERATION * delta)

	pollux.rotate_y(deg_to_rad(angular_velocity) * delta)
	return angular_velocity

# --- Propeller Spin ---
static func handle_propellers(main_propeller: Node3D, left_propeller: Node3D, right_propeller: Node3D,
							  velocity: Vector3, angular_velocity: float, delta: float, C) -> void:
	# Spin main propeller based on forward/backward thrust
	var forward_speed = velocity.z
	var main_spin = forward_speed * C.MAIN_PROPELLER_SPIN
	main_propeller.rotate_z(deg_to_rad(main_spin) * delta)

	# Spin side propellers based on angular velocity
	var side_spin = abs(angular_velocity) * C.SIDE_PROPELLER_SPIN
	# Opposite directions for realism
	left_propeller.rotate_z(deg_to_rad(side_spin) * delta)
	right_propeller.rotate_z(deg_to_rad(side_spin) * delta)

# --- Deploy Akas ---
static func DeployAkas(left_aka: Node3D, right_aka: Node3D, duration: float, C) -> void:
	var half_duration = duration / 2.0

	# Left aka: first half to midpoint, second half to final
	var tween_left := left_aka.create_tween()
	tween_left.tween_property(left_aka, "rotation_degrees:z", C.AKA_LEFT_FINAL / 2.0, half_duration)
	tween_left.tween_property(left_aka, "rotation_degrees:z", C.AKA_LEFT_FINAL, half_duration)

	# Right aka: same idea, but mirrored
	var tween_right := right_aka.create_tween()
	tween_right.tween_property(right_aka, "rotation_degrees:z", C.AKA_RIGHT_FINAL / 2.0, half_duration)
	tween_right.tween_property(right_aka, "rotation_degrees:z", C.AKA_RIGHT_FINAL, half_duration)


static func FoldAkas(left_aka: Node3D, right_aka: Node3D, duration: float, C) -> void:
	var half_duration = duration / 2.0

	# Left aka: fold back in two steps
	var tween_left := left_aka.create_tween()
	tween_left.tween_property(left_aka, "rotation_degrees:z", C.AKA_LEFT_FINAL / 2.0, half_duration)
	tween_left.tween_property(left_aka, "rotation_degrees:z", C.AKA_LEFT_INITIAL, half_duration)

	# Right aka: fold back in two steps
	var tween_right := right_aka.create_tween()
	tween_right.tween_property(right_aka, "rotation_degrees:z", C.AKA_RIGHT_FINAL / 2.0, half_duration)
	tween_right.tween_property(right_aka, "rotation_degrees:z", C.AKA_RIGHT_INITIAL, half_duration)
# --- Deploy Camera Bracket + Camera ---
static func DeployCamera(camA: Node3D, camB: Node3D, camC: Node3D, camBody: Node3D, duration: float, C) -> void:
	camA.create_tween().tween_property(camA, "rotation_degrees",
		Vector3(camA.rotation_degrees.x, camA.rotation_degrees.y, C.CAM_A_FINAL), duration)
	camB.create_tween().tween_property(camB, "rotation_degrees",
		Vector3(camB.rotation_degrees.x, camB.rotation_degrees.y, C.CAM_B_FINAL), duration)
	camC.create_tween().tween_property(camC, "rotation_degrees",
		Vector3(camC.rotation_degrees.x, camC.rotation_degrees.y, C.CAM_C_FINAL), duration)
	camBody.create_tween().tween_property(camBody, "rotation_degrees",
		Vector3(camBody.rotation_degrees.x, camBody.rotation_degrees.y, C.CAM_BODY_FINAL), duration)

# --- Deploy Handlebar ---
static func DeployBarHandle(handle_left: Node3D, handle_right: Node3D, duration: float, C) -> void:
	handle_left.create_tween().tween_property(handle_left, "rotation_degrees",
		Vector3(handle_left.rotation_degrees.x, handle_left.rotation_degrees.y, C.HANDLE_LEFT_FINAL), duration)
	handle_right.create_tween().tween_property(handle_right, "rotation_degrees",
		Vector3(handle_right.rotation_degrees.x, handle_right.rotation_degrees.y, C.HANDLE_RIGHT_FINAL), duration)
