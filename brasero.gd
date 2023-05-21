extends StaticBody3D
const OBJ_FIRE: Object = preload("res://fire.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	print("start fire")
	var fire = OBJ_FIRE.instantiate()
	fire.position = Vector3i(0.0,2.215,0.024)
	fire.set_shadows(true)
	fire.set_attenuation(1.5)
	add_child(fire)

