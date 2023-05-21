extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globals.total_braseros == Globals.nb_brasero_up:
		environment.sky.sky_material.sky_energy_multiplier = 0.1
		$"../DirectionalLight3D".visible = true
	else:
		environment.sky.sky_material.sky_energy_multiplier = 0.0
		$"../DirectionalLight3D".visible = false
		
