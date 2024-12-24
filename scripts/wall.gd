extends AnimatedSprite2D

@export var max_hp: float = 100
var current_hp:float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_hp = max_hp
	self.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func broken():
	self.play("break")

func damage(value: int) -> void:
	current_hp -= value
	if current_hp < 0:
		return
		
	# HP割合を計算
	var hp_percentage = current_hp / max_hp
	print(hp_percentage)
	# HPに応じてアニメーションを再生
	if current_hp <= 0:
		broken()
	elif hp_percentage <= 0.2:
		play("6")
	elif hp_percentage <= 0.3:
		play("5")
	elif hp_percentage <= 0.5:
		play("4")
	elif hp_percentage <= 0.7:
		play("3")
	elif hp_percentage <= 0.8:
		play("2")
	elif hp_percentage <= 0.9:
		play("1")
	


func _on_animation_finished() -> void:
	if self.animation == "break":
		queue_free()
