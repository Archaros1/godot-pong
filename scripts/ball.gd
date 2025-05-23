extends CharacterBody2D


const START_SPEED = 100.0
const START_ANGLE = 45.0

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
	
	# Once we start moving.
	var vector = get_direction_from_rota(angle)
	velocity.x = vector.x * speed
	velocity.y = vector.y * speed

	move_and_slide()

func get_direction_from_rota(angle: float) -> Dictionary:
	return {'x': cos(angle), 'y': sin(angle)}
