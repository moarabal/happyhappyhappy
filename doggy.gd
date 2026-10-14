extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite
var time: float = 0

const max_speed = 300.0
const acel = 2000.0
const friction = 2800.0



func _physics_process(delta: float) -> void:

	player_movement(delta)

	move_and_slide()






func player_movement(delta) -> void:
	
	var input = Vector2.ZERO
	
	input.x = Input.get_axis("left", "right")
	input.y = Input.get_axis("up","down")
	
	input = input.normalized()
	
	
	
	
	if input :
		velocity += (input * acel * delta)
		velocity = velocity.limit_length(max_speed)
		wobble(delta)
	else:
		if velocity.length()>(friction*delta):
			velocity-= velocity.normalized() * (friction*delta)
		else:
			velocity = Vector2.ZERO
			sprite.rotation = 0
		
func wobble(delta) -> void:
	sprite.rotation = sin(time*10)*0.1
	time += delta
	
	
	
