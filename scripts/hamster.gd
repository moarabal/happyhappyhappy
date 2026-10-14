extends CharacterBody2D

@onready var hamster_sprite: AnimatedSprite2D = $hamster_sprite

var player: Node2D = null
const max_speed = 200.0
const acel = 4000.0
const friction = 2800.0

@export var dmg = 1

var time = 0.0


func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if player:
		var direction = position.direction_to(player.global_position)
		velocity = (direction*acel*delta)
		wobble(delta)
		if direction.x >0.0:
			hamster_sprite.flip_h = true
		elif direction.x < 0.0:
			hamster_sprite.flip_h = false
		
		player.p_hurt(dmg)
		
		

	move_and_slide()




func wobble(delta) -> void:
	hamster_sprite.rotation = sin(time*10)*0.1
	time += delta
