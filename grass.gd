extends Node2D

const GRASS_EFFECT = preload("res://effects/grass_effect.tscn")#this gives us access to the grass scene file so we can later dynamically instantiate it

@onready var area_2d: Area2D = $Area2D#this accesses the area 2d so i can use it in the script

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered)#this connects the signal in brackets to the code WITH code instead of from the editor which is more reliable:>

func _on_area_2d_area_entered(other_area_2d: Area2D) -> void:
	var grass_effect_instance = GRASS_EFFECT.instantiate()
	get_tree().current_scene.add_child(grass_effect_instance)
	grass_effect_instance.global_position = global_position
	queue_free()
