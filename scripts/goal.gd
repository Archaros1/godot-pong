extends Area2D

@onready var ball: CharacterBody2D = $"../ball"
@onready var score: RichTextLabel = $"../score"
@onready var score_2: RichTextLabel = $"../score2"

func _on_body_entered(body: Node2D) -> void:
	var goalerId = get_meta("playerId")
	
	if !has_meta("pointCount"):
		set_meta("pointCount", 0)
	if body == ball:
		var point_count = get_meta("pointCount") + 1
		set_meta("pointCount", point_count)
		if score.get_meta("playerId") == goalerId:
			score.set("text", point_count)
		if score_2.get_meta("playerId") == goalerId:
			score_2.set("text", point_count)
		reset_ball(goalerId)

func reset_ball(goalerId: int = 0) -> void:
	ball.set_meta("gameOn", false)
	ball.position = Vector2(0, 0)
	ball.randomizeAngle(goalerId)
	
	
	
	
