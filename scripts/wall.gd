extends AnimatedSprite2D

@export var current_hp:int = 10;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func broken():
	self.play("break")

func damage(value: int):
	current_hp -= value
	
	if current_hp < 0:
		broken()

func _on_animation_finished() -> void:
	if self.animation == "break":
		queue_free()
