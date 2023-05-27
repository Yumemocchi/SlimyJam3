extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	print("yohohhh")
	if body.is_in_group("player"):
		print("yoho")
		if Globals.vie <= 80.0:
			print("vie")
			Globals.vie += 20.0
			queue_free()
