extends Node3D

const WAVE_SCENE = preload("res://models/Wave.gltf")

const SPAWN_POS = Vector3(50, 5, 50)
const FINAL_POS_X = 50.0
const INITIAL_ALPHA = 1.0
const MAX_ALPHA = 1.0
const FINAL_ALPHA = 1.0
const ALPHA_CHANGE_RATE = 1.0
const MOVE_SPEED = 10.0
const FADE_DISTANCE = 5.0

var waves = []

func _process(delta):
	for wave in waves:
		# Move forward
		wave.translate(Vector3(MOVE_SPEED * delta, 0, 0))

		# Handle alpha increase (spawn → full visibility)
		var mat = wave.get_surface_override_material(0)
		
		if mat:
			if wave.translation.x < FINAL_POS_X - FADE_DISTANCE:
				mat.albedo_color.a = clamp(mat.albedo_color.a + ALPHA_CHANGE_RATE * delta, INITIAL_ALPHA, MAX_ALPHA)
				print("Wave alpha: ", mat.albedo_color.a)
			else:
				# Fade out near beach
				var dist_to_end = FINAL_POS_X - wave.translation.x
				var alpha = clamp(dist_to_end / FADE_DISTANCE, FINAL_ALPHA, MAX_ALPHA)
				mat.albedo_color.a = alpha

		# Cleanup
		if wave.translation.x >= FINAL_POS_X:
			waves.erase(wave)
			wave.queue_free()

func spawn_wave():
	


	var wave = WAVE_SCENE.instantiate()
	print("Wave spawned at: ", wave.translation)
	print("Wave scale: ", wave.scale)
	
	wave.translation = SPAWN_POS
	var mat = wave.get_surface_override_material(0)
	if mat:
		mat.albedo_color.a = INITIAL_ALPHA
	add_child(wave)
	waves.append(wave)
