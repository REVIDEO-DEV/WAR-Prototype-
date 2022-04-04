extends KinematicBody2D

var max_speed = 400
var speed = 0
var acceleration = 1200
var move_direction
var moving = false
var destination = Vector2()
var movement = Vector2()

func _unhandled_input(event):
	if event.is_action_pressed("Click"):
		moving = true
		destination = get_global_mouse_position()

func _physics_process(delta):
	MovementLoop(delta)

func MovementLoop(delta):
	if moving == false:
		speed = 0
	else:
		speed += acceleration * delta
	if speed > max_speed:
		speed = max_speed
	movement = position.direction_to(destination) * speed
	move_direction = rad2deg(destination.angle_to_point(position))
	if position.distance_to(destination) > 3:
		movement = move_and_slide(movement)
	else:
		moving = false

	if move_direction <= 15 and move_direction >= -15:
		$AnimatedSprite.play("Side") 
		$AnimatedSprite.flip_h = true
	elif move_direction <= 60 and move_direction >= 15:
		$AnimatedSprite.play('Front(side)')
		$AnimatedSprite.flip_h = true
	elif move_direction <= 120 and move_direction >= 60:
		$AnimatedSprite.play('Front')
	elif move_direction <= 165 and move_direction >= 120:
		$AnimatedSprite.play('Front(side)')
		$AnimatedSprite.flip_h = false
	elif move_direction >= -60 and move_direction <= -15:
		$AnimatedSprite.play('Back(side)')
		$AnimatedSprite.flip_h = true
	elif move_direction >= -120 and move_direction <= -60:
		$AnimatedSprite.play('Back')
	elif move_direction >= -165 and move_direction >= -120:
		$AnimatedSprite.play('Back(side)')
		$AnimatedSprite.flip_h = false
	elif move_direction <= -165 or move_direction >= 165:
		$AnimatedSprite.play("Side") 
		$AnimatedSprite.flip_h = false
