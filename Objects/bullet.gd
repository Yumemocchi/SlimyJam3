extends Node3D

@onready var SPEED := 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position.y += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var forward_direction = transform.basis.z.normalized()
	global_translate(forward_direction * SPEED * delta)
	#print(forward_direction)


func _on_area_3d_body_entered(body):
	queue_free()
