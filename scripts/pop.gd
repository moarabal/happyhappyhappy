extends Area2D

var player : Node2D = null


var SPEED = 500.0
var direction : Vector2
var rangetrav = 0.0
@export var dmg = 1


func _ready() -> void:
	player=get_tree().get_first_node_in_group("player")


func _physics_process(delta: float) -> void:
	var movement = direction * SPEED * delta
	
	position+=movement
	
	rangetrav+=movement.length()
	if rangetrav>1000:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.get_parent().ehurt(dmg)
		queue_free()
