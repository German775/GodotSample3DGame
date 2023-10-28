extends Node

@export var mob_scene: PackedScene

func _ready():
	$UserInterface/Retry.hide()

func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	if $Player == null: 
		return
	
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	# We connect the mob to the score label to update the score upon squashing one.
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())
	
	add_child(mob)

func _on_player_hit():
	$UserInterface/Retry.show()
	$MobTimer.stop()


func _on_button_pressed():
	if $UserInterface/Retry:
		get_tree().reload_current_scene()
