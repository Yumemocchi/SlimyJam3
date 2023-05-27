extends CharacterBody3D

@onready var SPEED := 2.0
@onready var isAwake = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	#velocity = position.direction_to(Globals.player_position) * SPEED
	if not is_on_floor():
		velocity.y -= gravity * delta
			
	if isAwake:		
		look_at_from_position(position,Globals.player_position,Vector3.UP)
		rotate(Vector3.UP, PI)
		
		velocity.x = (Globals.player_position - position).normalized().x * SPEED
		velocity.z = (Globals.player_position - position).normalized().z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
			
	move_and_slide()



func isMoving():
	if velocity.length() > 0:
		return true
	else:
		return false
		
		
func _on_area_detection_body_entered(body):
	if !isMoving() and body.is_in_group("player"):
		$AnimationPlayerCube.play("CubeAction")
		isAwake = true


func _on_area_follow_body_exited(body):
	if body.is_in_group("player"):
		#await get_tree().create_timer(3.0).timeout
		$Timer.start()
		await $Timer.timeout
		isAwake = false


func _on_area_follow_body_entered(body):
	if isMoving() and body.is_in_group("player"):
		if !$Timer.is_stopped():
			print("stop")
			$Timer.stop()
