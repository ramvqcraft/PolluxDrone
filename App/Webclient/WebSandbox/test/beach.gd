extends Node3D

func _ready():
	# --- Water material ---
	var water_material := StandardMaterial3D.new()
	water_material.albedo_color = Color(0.1, 0.3, 0.6, 0.6) # bluish with alpha
	water_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	water_material.roughness = 0.1
	water_material.metallic = 0.0
	# Optional: add a normal map for ripples
	water_material.normal_texture = load("res://textures/water-body.jpg")

	# --- Sand material ---
	var sand_material := StandardMaterial3D.new()
	sand_material.albedo_texture = load("res://textures/sand.jpg")
	sand_material.roughness = 0.9
	# Optional: add a normal map for bumps
	# sand_material.normal_texture = load("res://textures/sand_normal.png")

	# Apply materials to meshes
	var water_mesh = $"World_ver2/Water/WaterMass"
	var sand_mesh = $"World_ver2/Ground/GroundMass"

	if water_mesh and water_mesh is MeshInstance3D:
		water_mesh.material_override = water_material
	if sand_mesh and sand_mesh is MeshInstance3D:
		sand_mesh.material_override = sand_material
