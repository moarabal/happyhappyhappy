extends Node2D

var button_type = null

#add menu de opcoes: keybind, musica on/off, tela de skins????????

func _on_play_pressed() -> void:
	button_type = "PLAY"
	$fade_transitions.show()
	$fade_transitions/fade_timer.start()
	$fade_transitions/AnimationPlayer.play("fade_in")
	print("apertou")
	#get_tree().change_scene_to_file("res://nivel_1.tscn")


func _on_options_pressed() -> void:
	button_type="OPTIONS"
	$fade_transitions.show()
	$fade_transitions/fade_timer.start()
	$fade_transitions/AnimationPlayer.play("fade_in")


func _on_bye_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	print("cabou tempo")
	if button_type=="PLAY":
		print("sabe que e start")
		get_tree().change_scene_to_file("res://nivel_1.tscn")
		
	elif button_type == "OPTIONS":
		#get_tree().change_scene_to_file()
		pass
