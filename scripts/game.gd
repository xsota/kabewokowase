extends Node

var is_game = false;
@export var start_count = 3;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	$StartTimer.start()
	$StartTimer/SE.play()
	$UI/StartCountDownLabel.text = str(start_count);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if !is_game:
		return
		
	if event.is_action_pressed("attack"):
		$Character.play("attack")
		$Character/SE.play()
		
		var wall = get_first_wall()
		if wall != null:
			wall.damage(1)
	
	else:
		$Character.play("default")

func get_first_wall():
	var index = $GroupWall.get_child_count()-1
	
	if index < 0:
		return null
	
	return $GroupWall.get_children()[index]
	

func _on_start_timer_timeout() -> void:
	start_count -= 1;
	
	if start_count >= 1:
		$UI/StartCountDownLabel.text = str(start_count);
		$StartTimer/SE.play()
	elif start_count == 0:
		$UI/StartCountDownLabel.text = "れんだしろ！！"
		is_game = true;
		$BGM.play();
	elif start_count == -1:
		$StartTimer.stop()
		$UI/StartCountDownLabel.hide()
		
