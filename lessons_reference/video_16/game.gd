extends Node3D
#MortezaPourmoghaddam 400435417
var player_score = 0

@onready var label := %Label
@onready var game_over_label := $GameOverLabel
@onready var backcolor := %ColorRect

func _unhandled_input(event):
	if event.is_action_pressed("restart_game"):
		get_tree().reload_current_scene.call_deferred()
	elif event.is_action_pressed("exit_game"):
		get_tree().quit()	
		
func increase_score():
	player_score += 1
	label.text = "Score: " + str(player_score)


func show_game_over():
	game_over_label.text = "Game over Your Score: " + str(player_score)
	game_over_label.visible = true
	backcolor.visible = true
	
	
func _on_kill_plane_body_entered(body):
	show_game_over()
	#get_tree().reload_current_scene.call_deferred()


func _on_mob_spawner_3d_mob_spawned(mob):
	mob.died.connect(func():
		increase_score()
		do_poof(mob.global_position)
	)
	do_poof(mob.global_position)


func do_poof(mob_position):
	const SMOKE_PUFF = preload("res://mob/smoke_puff/smoke_puff.tscn")
	var poof := SMOKE_PUFF.instantiate()
	add_child(poof)
	poof.global_position = mob_position
