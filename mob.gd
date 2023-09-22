extends CharacterBody3D

# Min speed meters/second.
@export var min_speed = 10
# Max speed meters/second.
@export var max_speed = 18

signal squashed

func _physics_process(_delta):
	move_and_slide()
	
# To be called from Main scene.
func initialize(start_position, player_position):
	# Position mob at start_position.
	# rotate it towards player_position.
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate mob randomly within -90/+90 deg
	# so it doesn't go directly to the player.
	rotate_y(randf_range(-PI/4, PI/4))
	
	# Get a random speed (int)
	var random_speed = randi_range(min_speed, max_speed)
	# Calculate forward velocity for speed.
	velocity = Vector3.FORWARD * random_speed
	# Rotate velocity based on mob's Y rotation.
	# in order to move in direction mob is looking.
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()

func squash():
	squashed.emit()
	queue_free()
