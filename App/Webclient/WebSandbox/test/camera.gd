extends Camera3D

@export var target_path : NodePath
@export var sensitivity : float = 0.3
@export var distance : float = 10.0
@export var height : float = 3.0
@export var zoom_speed : float = 1.0
@export var min_distance : float = 0.50
@export var max_distance : float = 25.0

var target : Node3D
var rotation_x : float = 0.0
var rotation_y : float = 0.0

func _ready():
	target = get_node("/root/Node3D/Pollux")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * sensitivity
		rotation_x -= event.relative.y * sensitivity
		rotation_x = clamp(rotation_x, -45.0, 45.0)

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			distance = max(min_distance, distance - zoom_speed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			distance = min(max_distance, distance + zoom_speed)

func _process(delta):
	if not target:
		return

	var target_pos = target.global_transform.origin
	var offset = Vector3(
		sin(deg_to_rad(rotation_y)) * distance,
		height,
		cos(deg_to_rad(rotation_y)) * distance
	)
	global_transform.origin = target_pos + offset
	look_at(target_pos, Vector3.UP)
