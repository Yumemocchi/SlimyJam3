extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _wizard_mesh = $Armature/Wizard
@onready var _staff_AP = $Armature/Wizard/staff/AnimationPlayer

@onready var _last_direction := Vector3.FORWARD
@onready var _direction := Vector3.ZERO
@onready var is_attacking := false
@onready var SPEED = 10.0
@onready var is_dashing = false


func  _ready() -> void:
	$pivot/Camera3D.near = -100
	
func _physics_process(delta):
	# Add the gravity.
	Globals.player_position = position

	if Globals.vie <=0:
		print("dead")
	
	if not is_on_floor():
		velocity.y -= gravity * delta


	# Gestion des mouvements
	var input_dir = Input.get_vector("left", "right", "up", "down")
		
	input_dir.normalized()
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * quaternion.from_euler(Vector3(0,45,0))
		
	var rotation_speed = 5.0
	if _direction.length() > 0.1:
		var target_rotation = atan2(_direction.x, _direction.z)
		_wizard_mesh.rotation.y = lerp_angle(_wizard_mesh.rotation.y, target_rotation, rotation_speed * delta)
		
		var angle = _wizard_mesh.position.angle_to(_direction)
		_last_direction = Vector3(_direction.x,0.0,_direction.z)
	
	if _direction:
		velocity.x = _direction.x * SPEED
		velocity.z = _direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	# Gestion des attaques
	is_attacking = Input.is_action_pressed("punch")
	
	if Input.is_action_just_pressed("punch"):
		_staff_AP.play("attack_animation",-1,3.0)
		Globals.set_burst(true)
	
	if Input.is_action_just_released("punch"):
		release_attack()
	
	if Input.is_action_just_pressed("dash") and !is_dashing:
		dash()

	if is_attacking:
		attack()
		
	#print(Globals.nb_brasero_up)

	move_and_slide()


func dash():
	is_dashing = true
	SPEED = 50
	await get_tree().create_timer(0.2).timeout
	SPEED = 10
	await get_tree().create_timer(0.5).timeout
	is_dashing = false	


func attack():
	pass
	#print("is attacking")


func release_attack():
	#print("release attack")
	_staff_AP.play("release_attack_animation")
	Globals.set_burst(false)
	Globals.resting = true


func _on_hurt_box_player_area_entered(area):
	if area.is_in_group("bullet"):
		print("hurt")
		Globals.vie -= Globals.hurt_power
