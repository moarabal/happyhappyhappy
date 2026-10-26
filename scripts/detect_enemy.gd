extends Node2D

@export var projscene: PackedScene

@onready var rangefinder: Area2D = $rangefinder
@onready var player: CharacterBody2D = $".."

#cooldown de detectar inimigos
@onready var timer: Timer = $Timer

#cooldown das armas:
@onready var popcooldown: Timer = $popcooldown





func _ready() -> void:
	timer.start()
	
	
	


func _on_timer_timeout() -> void:
	
	var enemyinrange = rangefinder.get_overlapping_areas()
	if enemyinrange.size()==0:
		return
	var target = null
	var shortestdis=INF
	
	for enemy in enemyinrange:
		var distance = global_position.distance_to(enemy.global_position)
		if distance < shortestdis:
			shortestdis = distance
			target = enemy
		
	if target:
		throwpop(projscene, target)
		

#func throwat(target) -> void:
	#var new_projectile = projscene.instantiate()
	
	#new_projectile.global_position = global_position
	
	#direction to target
	#var direction_to_target = global_position.direction_to(target.global_position)
	#new_projectile.direction = direction_to_target
	#get_tree().current_scene.add_child(new_projectile)


func throwat(target) -> void:
	throwpop(projscene, target)
	
	
	
func throwpop(projscene, target) -> void:
	if player.hp<1:
		return
	if popcooldown.is_stopped():
		var new_projectile = projscene.instantiate()
	
		new_projectile.global_position = global_position
	
		#direction to target
		var direction_to_target = global_position.direction_to(target.global_position)
		new_projectile.direction = direction_to_target
		get_tree().current_scene.add_child(new_projectile)
		popcooldown.start()
	
