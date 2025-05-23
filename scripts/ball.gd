extends CharacterBody2D


const START_SPEED = 100.0
const START_ANGLE = 45.0
@onready var ray_cast_top: RayCast2D = $RayCastTop
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_down: RayCast2D = $RayCastDown
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var paddle: CharacterBody2D = $"."

func _physics_process(delta: float) -> void:
	var gameOn = false
	
	# Start moving only after ui_accept.
	if Input.is_action_just_pressed("ui_accept"):
		set_meta('gameOn', true)
	
	if has_meta('gameOn'):
		gameOn = get_meta('gameOn')
	
	if !gameOn:
		set_meta('currentSpeed', START_SPEED)
		set_meta('currentAngle', START_ANGLE)
		return
	
	var speed = get_meta('currentSpeed')
	var angle = get_meta('currentAngle')
	
	angle = update_angle_on_collision(angle)
	speed = update_speed_on_collision_with_paddle(speed)
	
	# Once we start moving.
	var vector = get_direction_from_rota(angle)
	velocity.x = vector.x * speed
	velocity.y = vector.y * speed

	move_and_slide()
	
	set_meta('currentSpeed', speed)
	set_meta('currentAngle', angle)

func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(deg_to_rad(angle)), 'y': sin(deg_to_rad(angle))}

func update_angle_on_collision(angle: float) -> float:
	var collision_x_disabled = false
	var collision_y_disabled = false
	
	# Remember previous frame.
	if has_meta('collision_x_disabled'):
		collision_x_disabled = get_meta('collision_x_disabled')
	if has_meta('collision_y_disabled'):
		collision_y_disabled = get_meta('collision_y_disabled')
	
	# If collision enabled & colliding.
	if !collision_x_disabled && (ray_cast_right.is_colliding() || ray_cast_left.is_colliding()):
		set_meta('collision_x_disabled', true)
		angle = 180 - angle
	if !collision_y_disabled && (ray_cast_top.is_colliding() || ray_cast_down.is_colliding()):
		set_meta('collision_y_disabled', true)
		angle *= -1
	
	# Enable collisions if not colliding.
	if collision_x_disabled && !ray_cast_right.is_colliding() && !ray_cast_left.is_colliding():
		set_meta('collision_x_disabled', false)
	if collision_y_disabled && !ray_cast_top.is_colliding() && !ray_cast_down.is_colliding():
		set_meta('collision_y_disabled', false)
	
	return angle

func update_speed_on_collision_with_paddle(speed: float) -> float:
	var collider = null
	if ray_cast_top.is_colliding():
		collider = ray_cast_top.get_collider()
	if ray_cast_right.is_colliding():
		collider = ray_cast_right.get_collider()
	if ray_cast_down.is_colliding():
		collider = ray_cast_down.get_collider()
	if ray_cast_left.is_colliding():
		collider = ray_cast_left.get_collider()
	
	if collider && collider.is_class('CharacterBody2D'):
		speed += 10

	return speed
