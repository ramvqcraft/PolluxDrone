extends Node3D

var water_material : StandardMaterial3D

func _ready():
	# --- Water material ---
	water_material = StandardMaterial3D.new()
	water_material.albedo_color = Color(0.1, 0.3, 0.6, 0.6)
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.metallic = 1
	water_material.roughness = 0.5   # more diffuse reflections

	# Load and enable normal map properly
	water_material.normal_enabled = true
	water_material.normal_texture = load("res://textures/water-body.jpg")
	water_material.normal_scale = 0.7  # controls wave intensity

	# --- Sand material ---
	var sand_material := StandardMaterial3D.new()
	sand_material.albedo_texture = load("res://textures/sand.jpg")
	sand_material.roughness = 0.9

	# Apply materials
	var water_mesh = $"World_ver2/Water/WaterMass"
	var sand_mesh = $"World_ver2/Ground/GroundMass"

	if water_mesh and water_mesh is MeshInstance3D:
		water_mesh.material_override = water_material
	if sand_mesh and sand_mesh is MeshInstance3D:
		sand_mesh.material_override = sand_material


func _process(delta):
	# Animate water ripples by scrolling UVs
	if water_material:
		water_material.uv1_offset.x += 0.01 * delta
		water_material.uv1_offset.y += 0.01 * delta
