extends Node

@export var mob_scene: PackedScene

func _ready():
	$UserInterface/Retry.hide()
	
func _on_mob_timer_timeout():
	# Create a new instance of Mob
	var mob = mob_scene.instantiate()
	
	# Choose a random location on SpawnPath
	# Store the reference into SpawnLocation node
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# Give it random offset
	mob_spawn_location.progress_ratio = randf()
	
	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)
	
	# Spawn mob by adding to Main scene
	add_child(mob)
	
	# Connect the mob to the score label to update score upon squashing
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())


func _on_player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()
	
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# Restart the current scene
		get_tree().reload_current_scene()
