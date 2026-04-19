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
