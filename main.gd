extends Node

func _ready():
	$Label.hide()
	SignalBus.gameover.connect(gameover)
	
func gameover():
	get_tree().paused = true
	$Label.show()
	await get_tree().create_timer(4.0).timeout
	get_tree().quit()
