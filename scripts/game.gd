extends Node

var is_game = false;
var score_time = 0.0
@export var start_count = 3;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$UI/TitleGoButton.hide()
	randomize()
	$StartTimer.start()
	$StartTimer/SE.play()
	$UI/StartCountDownLabel.text = str(start_count);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_game:
		score_time += delta
		$UI/ScoreTimeLabel.text = "Time: %.2f" % score_time
		
	if $GroupWall.get_child_count() == 0 and is_game:
		is_game = false
		$TitleButtonTimer.start()
		$BGM.stop();
		$UI/ScoreTimeLabel.hide()
		$UI/ResultsLabel.text = "%.2f秒で\n103万の壁たちを壊した！" % score_time
		$TitleButtonTimer.start()


func _input(event: InputEvent) -> void:
	if !is_game:
		return
		
	if event.is_action_pressed("attack"):
		$Character.play("attack")
		$Character/SE.play()	
		
		var wall = get_first_wall()
		if wall != null:
			wall.damage(1)
			shake_node(wall)
	
	else:
		$Character.play("default")


func get_first_wall():
	var index = $GroupWall.get_child_count()-1
	
	if index < 0:
		return null
	var w = $GroupWall.get_children()[index]
	if null != w:
		if w.current_hp == 0:
			return $GroupWall.get_children()[index-1]
		else:
			return w

func shake_node(target: Node2D, intensity: float = 1, duration: float = 0.1) -> void:
	var tween = get_tree().create_tween()  # Tweenを作成
	var original_position = target.position  # 元の位置を記録
	
	# シェイクアニメーションを追加
	for i in range(int(duration / 0.1)):  # 揺れる回数を計算（0.1秒ごと）
		var random_offset = Vector2(
			randf_range(-intensity, intensity),
			randf_range(-intensity, intensity)
		)
		# ランダムな位置に移動
		tween.tween_property(
			target, "position", original_position + random_offset, 0.05
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		
		# 元の位置に戻る
		tween.tween_property(
			target, "position", original_position, 0.05
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		

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


func _on_title_button_timer_timeout() -> void:
	$UI/TitleGoButton.show()


func _on_title_go_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title.tscn")
