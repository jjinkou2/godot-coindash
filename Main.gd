extends Node

export (PackedScene) var Coin
export (int) var playtime

var level
var score 
var screensize
var time_left
var playing = false


func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize=screensize
	$Player.hide()


func _process(_delta):
	if playing and $CoinContainer.get_child_count()==0:
		level += 1
		time_left += 5
		spawn_coins()
		
	
func _new_game():
	playing=true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$GameTimer.start()
	spawn_coins()
	$HUD._update_score(score)
	$HUD._update_timer(time_left)

func spawn_coins():
	for _i in range(4 + level):
		var c = Coin.instance()
		$CoinContainer.add_child(c)
		c.screensize = screensize
		c.position = Vector2(rand_range(0, screensize.x),
							 rand_range(0, screensize.y))	
	


func _on_GameTimer_timeout():
	time_left -=1
	$HUD._update_timer(time_left)
	if time_left <0:
		game_over()




func _on_Player_hurt():
	game_over()


func _on_Player_pickup():
	score +=1
	$HUD._update_score(score)

func game_over():
	playing=false
	$GameTimer.stop()
	for coin in $CoinContainer.get_children():
		coin.queue_free()
	$HUD.show_game_over()	
	$Player.die()
	



