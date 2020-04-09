extends CanvasLayer
signal start_game

func _update_score(val):
	$MarginContainer/ScoreLabel.text = str(val)
	
func _update_timer(val):
	$MarginContainer/TimeLabel.text = str(val)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _show_message(text):
	$MessageLabel.text = text
	$MessageTimer.start()
	$MessageLabel.show()
	

func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_Button_pressed():
	$MessageLabel.hide()
	$StartButton.hide()
	emit_signal("start_game")
	
func show_game_over():
	_show_message("Game Over")
	yield($MessageTimer,"timeout")
	$StartButton.show()
	$MessageLabel.text="Coin Dash !"
	$MessageLabel.show()
	
