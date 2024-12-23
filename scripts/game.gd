extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
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
	
