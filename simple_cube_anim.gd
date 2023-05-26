extends CharacterBody3D

@onready var SPEED := 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	#velocity = position.direction_to(Globals.player_position) * SPEED
	
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	look_at_from_position(position,Globals.player_position,Vector3.UP)
	rotate(Vector3.UP, PI)
	
	velocity.x = (Globals.player_position - position).normalized().x * SPEED
	velocity.z = (Globals.player_position - position).normalized().z * SPEED
		
	move_and_slide()


func _on_area_3d_body_entered(body):
	print("enter")
	$AnimationPlayerCube.play("CubeAction")
