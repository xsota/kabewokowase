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
		$Wall.damage(1)
		$Character/SE.play()

	else:
		$Character.play("default")
