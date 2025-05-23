extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const CONTROL_BY_PLAYER = [
	[KEY_Z, KEY_S],
	[KEY_UP, KEY_DOWN],
]


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := int(Input.is_key_pressed(CONTROL_BY_PLAYER[get_meta("playerId")][1])) - int(Input.is_key_pressed(CONTROL_BY_PLAYER[get_meta("playerId")][0]))
	if direction:
		velocity.y = direction * SPEED
	else:
		velocity.y = 0

	move_and_slide()
