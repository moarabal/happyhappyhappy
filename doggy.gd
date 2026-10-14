extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $sprite
var time: float = 0

const max_speed = 300.0
const acel = 4000.0
const friction = 2800.0

var maxhp = 10
var hp = maxhp

var imune=false
@onready var imunity: Timer = $imunity


var inhitbox=false

@onready var hitbox: Area2D = $hitbox

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D



func _ready() -> void:
	sprite.play("default")
	var camera = get_tree().get_first_node_in_group("main_camera")
	remote_transform_2d.remote_path = camera.get_path()
	


func _physics_process(delta: float) -> void:

	
	
	if hp>0:
		player_movement(delta)
	else:
		sprite.play("dead")
	

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



func _on_hitbox_area_entered(area: Area2D) -> void:
	inhitbox=true


func _on_hitbox_area_exited(area: Area2D) -> void:
	inhitbox=false
	

func _on_sprite_animation_finished() -> void:
	sprite.play("default")
	

func p_hurt(dmg) -> void:
	if imune:
		return
	if inhitbox and hp>0:
		sprite.play("hurt_doggo")
		hp-=dmg
		print("vida: ",hp," / ", maxhp)
		
		imune=true
		imunity.start()
		
		


func _on_imunity_timeout() -> void:
	imune=false
