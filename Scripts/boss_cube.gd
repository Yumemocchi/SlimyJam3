extends CharacterBody3D

@onready var SPEED := 10.0
@onready var isAwake = false
@onready var life = 10
@onready var is_hurting = false
@onready var is_player_near = false
@onready var can_shoot = false
@onready var max_bullets = 5
@onready var _timer = $Timer

@export var OBJ_BULLET: PackedScene

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	#velocity = position.direction_to(Globals.player_position) * SPEED
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_hurting:
		life -= 1 * delta
	
	if life <= 0:
		get_tree().change_scene_to_file("res://good_end.tscn")
		#queue_free()
		

	if isAwake:
		if can_shoot:
			shoot()
			
		look_at_from_position(position,Globals.player_position,Vector3.UP)
		rotate(Vector3.UP, PI)
		if !is_player_near:
			velocity.x = (Globals.player_position - position).normalized().x * SPEED
			velocity.z = (Globals.player_position - position).normalized().z * SPEED
		else:
			velocity.x = 0.0
			velocity.z = 0.0
	else:
		velocity.x = 0.0
		velocity.z = 0.0
			
	move_and_slide()

func shoot():
	var bullet = OBJ_BULLET.instantiate()

	bullet.global_transform = global_transform
	get_parent().add_child(bullet)
	can_shoot = false

func isMoving():
	if velocity.length() > 0:
		return true
	else:
		return false
		
		
func _on_area_detection_body_entered(body):
	if !isMoving() and body.is_in_group("player"):
		$AnimationPlayerCube.play("CubeAction")
		isAwake = true
	if body.is_in_group("player"):
		is_player_near = true


func _on_area_detection_body_exited(body):
	if body.is_in_group("player"):
		is_player_near = false


func _on_area_follow_body_exited(body):
	if body.is_in_group("player"):
		#await get_tree().create_timer(3.0).timeout
		_timer.start()
		await _timer.timeout
		isAwake = false



func _on_area_follow_body_entered(body):
	if isMoving() and body.is_in_group("player"):
		if !_timer.is_stopped():
			_timer.stop()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("player_attack"):
		is_hurting = true
		$AnimationPlayerCube.play("hurt_animation")


func _on_hurt_box_area_exited(area):
	if area.is_in_group("player_attack"):
		is_hurting = false
		if $AnimationPlayerCube.is_playing():
			$AnimationPlayerCube.stop()


func _on_timer_bullet_timeout():
	can_shoot = true
