extends CharacterBody2D

@onready var hamster_sprite: AnimatedSprite2D = $hamster_sprite
@onready var bate: Timer = $bate

var player: Node2D = null
const max_speed = 1000.0
const acel = 9000.0
const friction = 2800.0

var inphitbox : bool



@export var dmg = 1
@export var maxhp = 1
var hp = maxhp



var time = 0.0

func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	if player:
		if not inphitbox:
			var direction = position.direction_to(player.global_position)
			wobble(delta)
			if direction.x >0.0:
				hamster_sprite.flip_h = true
			elif direction.x < 0.0:
				hamster_sprite.flip_h = false
			velocity = (direction*acel*delta)
			velocity = velocity.limit_length(max_speed)
			print(velocity)
		else:
			if velocity.length()>(friction*delta):
				velocity-= velocity.normalized() * (friction*delta)
			else:
				velocity = Vector2.ZERO
				hamster_sprite.rotation = 0
		
		
		
		

	move_and_slide()

func wobble(delta) -> void:
	hamster_sprite.rotation = sin(time*10)*0.1
	time += delta


func _on_bate_timeout() -> void:
	if inphitbox and player.hp>0:
		player.p_hurt(dmg)
		bate.start()



func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		inphitbox = true
		if player.hp>0:
			player.p_hurt(dmg)
			bate.start()


func _on_hurtbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("player"):
		inphitbox = false
		bate.stop()
		



func ehurt(dmg) -> void:
	if hp>0:
		#sprite.play("hurt")
		hp-=dmg
		print("vida hamster: ",hp," / ", maxhp)
		
		if hp<1:
			die()



func die() -> void:
	#hamster_sprite.play("dead")
	velocity = Vector2.ZERO
	hamster_sprite.rotation = 0
	queue_free()
