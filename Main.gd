extends Node

export (PackedScene) var Mob
var score

func _ready():
	randomize()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func game_over():
	$ScoreTImer.stop()
	$MobTimer.stop()


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTImer.start()


func _on_ScoreTImer_timeout():
	score += 1


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.MIN_SPEED, mob.MAX_SPEED), 0).rotated(direction))
