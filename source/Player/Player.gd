extends KinematicBody

const GRAVITY = -24.8
const MAX_SPEED = 10
const JUMP_SPEED = 12
const ACCEL = 2.5
const FRICTION = 16

const SENS = 0.05

var dir = Vector3.ZERO
var vel = Vector3.ZERO

var isFlying = false

onready var camera 			= $RotationHelper/Camera
onready var rotation_helper = $RotationHelper
onready var raycast 		= $RotationHelper/Camera/RayCast
onready var hand 			= $RotationHelper/Hand
onready var clip_cast		= $"RotationHelper/Camera/RayCast-Clip"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	process_input(delta)
	process_movement(delta)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		process_mouse(event)
	if event is InputEventKey and event.is_action_pressed("interact"):
		handle_object()
	if event is InputEventKey and event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton and event.is_pressed():
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

		
func yeet_object():
	if hand.get_child_count() > 0:
		var object = hand.get_child(0)
		drop_object(object)
		object.apply_central_impulse(camera.global_transform.basis.z * -40)
		
func drop_object(object):
	if clip_cast.is_colliding():
		return
	hand.remove_child(object)
	get_tree().root.get_child(0).add_child(object)
	object.mode = RigidBody.MODE_RIGID
	object.linear_velocity = vel;
	object.set_translation(hand.global_transform.origin)
	object.set_rotation(Vector3(rotation_helper.rotation.x, self.rotation.y, self.rotation.z))
	
func pickup_object(object):
	object.get_parent().remove_child(object)
	hand.add_child(object)
	object.mode = RigidBody.MODE_KINEMATIC
	object.set_rotation(Vector3.ZERO)
	object.set_translation(Vector3(0,0,0))
	
func handle_object():
	if raycast.is_colliding():
		var object = raycast.get_collider()
		if hand.get_child_count() > 0:
			drop_object(object)
		else:
			pickup_object(object)

func process_mouse(event):
		rotation_helper.rotate_x(deg2rad(event.relative.y * SENS * -1))
		self.rotate_y(deg2rad(event.relative.x * SENS * -1))
		
		var rotX = rotation_helper.rotation_degrees.x
		rotX = clamp(rotX, -90, 90)
		rotation_helper.rotation_degrees.x = rotX

func process_input(delta):
	var input_vector = Vector2()
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")
	
	input_vector = input_vector.normalized()
	
	
	var cam_trans = camera.get_global_transform()
	dir = Vector3.ZERO
	dir += -cam_trans.basis.z * input_vector.y
	dir += cam_trans.basis.x * input_vector.x
	
	if Input.is_action_pressed("fire1"):
		yeet_object()
	
	if is_on_floor() and Input.is_action_pressed("move_jump"):
		vel.y = JUMP_SPEED
	
func process_movement(delta):
	dir.y = 0
	dir = dir.normalized()

	vel.y += delta * GRAVITY
	
	var hvel = vel
	hvel.y = 0
	
	var target = dir * MAX_SPEED
	var accel
	
	if dir.dot(hvel) > 0:
		accel = ACCEL
	else:
		accel = FRICTION
	
	
	hvel = hvel.linear_interpolate(target, accel * delta)

	if isFlying == false:
		vel.x = hvel.x
		vel.z = hvel.z

	vel = move_and_slide(vel, Vector3(0,1,0), 0.05, 4, deg2rad(40), false)
