extends CharacterBody3D


const SPEED = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var _wizard_mesh = $Armature/Wizard
@onready var _last_direction := Vector3.FORWARD
@onready var _direction := Vector3.ZERO

func  _ready() -> void:
	#_animation.set("parameters/Blend3/blend_amount",-1)
	$pivot/Camera3D.near = -100
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
		
	input_dir.normalized()
	_direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y))# * quaternion.from_euler(Vector3(0,0,0)
		
	var rotation_speed = 5.0
	if _direction.length() > 0.1:
		var target_rotation = atan2(_direction.x, _direction.z)
		_wizard_mesh.rotation.y = lerp_angle(_wizard_mesh.rotation.y, target_rotation, rotation_speed * delta)
		_last_direction = Vector3(_direction.x,0.0,_direction.z)

	print(_last_direction)
	print(_direction)
	
	var is_attacking = Input.is_action_just_pressed("punch")

	if _direction:
		velocity.x = _direction.x * SPEED
		velocity.z = _direction.z * SPEED
	#	_animation.set("parameters/Blend3/blend_amount",1)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	#	_animation.set("parameters/Blend3/blend_amount",-1)
	
	if is_attacking:
		print("attack")
		attack()		

	move_and_slide()
	
func attack():
	pass
	#_animation.set("parameters/OneShot/request", true)
