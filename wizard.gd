extends CharacterBody3D

var SPEED = 10.0
var is_dashing = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _wizard_mesh = $Armature/Wizard
@onready var _staff_AP = $Armature/Wizard/staff/AnimationPlayer

@onready var _last_direction := Vector3.FORWARD
@onready var _direction := Vector3.ZERO

func  _ready() -> void:
	$pivot/Camera3D.near = -100
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var input_dir = Input.get_vector("left", "right", "up", "down")
		
	input_dir.normalized()
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()# * quaternion.from_euler(Vector3(0,0,0)
		
	var rotation_speed = 5.0
	if _direction.length() > 0.1:
		var target_rotation = atan2(_direction.x, _direction.z)
		_wizard_mesh.rotation.y = lerp_angle(_wizard_mesh.rotation.y, target_rotation, rotation_speed * delta)
		
		var angle = _wizard_mesh.position.angle_to(_direction)
		print(_direction)
		_last_direction = Vector3(_direction.x,0.0,_direction.z)
	
	var is_attacking = Input.is_action_just_pressed("punch")
	
	if Input.is_action_just_pressed("dash") and !is_dashing:
		dash()

	if _direction:
		velocity.x = _direction.x * SPEED
		velocity.z = _direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if is_attacking:
		attack()	

	move_and_slide()
			

func dash():
	is_dashing = true
	SPEED = 50
	await get_tree().create_timer(0.2).timeout
	SPEED = 10
	await get_tree().create_timer(1.0).timeout
	is_dashing = false	
	
func attack():
	print("attack")
	_staff_AP.play("attack_animation")

