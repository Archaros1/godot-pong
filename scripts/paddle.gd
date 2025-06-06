extends CharacterBody2D


const SPEED = 300.0
const COORD_X = 140
const CONTROL_BY_PLAYER = [
	[KEY_Z, KEY_S],
	[KEY_UP, KEY_DOWN],
]


func _physics_process(_delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var playerId = get_meta("playerId")
	var direction = set_direction(playerId)
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = 0

	position.x = set_position_x(playerId)

	move_and_slide()

func set_direction(playerId: int) -> int:
	var direction = 0
	if has_meta('direction'):
		direction = get_meta('direction')

	var directionLocked = false
	if has_meta('directionLocked'):
		directionLocked = get_meta('directionLocked')

	if (
		!Input.is_key_pressed(CONTROL_BY_PLAYER[playerId][1]) 
		|| !Input.is_key_pressed(CONTROL_BY_PLAYER[playerId][0])
		|| direction == 0
	):
		direction = int(Input.is_key_pressed(CONTROL_BY_PLAYER[playerId][1])) - int(Input.is_key_pressed(CONTROL_BY_PLAYER[playerId][0]))
		set_meta('direction', direction)
		set_meta('directionLocked', false)
		return direction

	# Both pressed & no previous direction saved.
	if !directionLocked:
		direction = -1 * direction
		set_meta('direction', direction)
		set_meta('directionLocked', true)

	return direction

func set_position_x(playerId: int) -> float:
	if playerId == 0:
		return -1 * COORD_X
	else:
		return COORD_X
