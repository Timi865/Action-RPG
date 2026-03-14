extends Node2D

@onready var area_2d: Area2D = $Area2D#this accesses the area 2d so i can use it in the script

func _ready() -> void:
	area_2d.area_entered.connect(_on_area_2d_area_entered)#this connects the signal in brackets to the code WITH code instead of from the editor which is more reliable:>

func _on_area_2d_area_entered(other_area_2d: Area2D) -> void:
	queue_free()
	print("grass area entered")
