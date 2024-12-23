extends AnimatedSprite2D

@export var current_hp:int = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damage(value: int):
	current_hp -= value
	if current_hp < 0:
		queue_free()
		
