extends Node2D

var level_scene = preload("res://scenes/level.tscn").instantiate()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")
