extends Area2D

var player : Node2D = null

@onready var cooldown: Timer = $cooldown

var spin = 10.0
var SPEED = 500.0
var direction = Vector2.RIGHT
var rangetrav = 0.0
@export var dmg = 1


func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")
	cooldown.start()


func _physics_process(delta: float) -> void:
	var movement = direction * SPEED * delta
	rotation -= delta * spin
	
	position+=movement
	
	rangetrav+=movement.length()
	if rangetrav>1000:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().ehurt(dmg)
	queue_free()


func throwpop(projscene, target) -> void:
	if cooldown.is_stopped():
		var new_projectile = projscene.instantiate()
	
		new_projectile.global_position = global_position
	
		#direction to target
		var direction_to_target = global_position.direction_to(target.global_position)
		new_projectile.direction = direction_to_target
		get_tree().current_scene.add_child(new_projectile)
		cooldown.start()

func fala() -> void:
	print("o problema e a funcao")
