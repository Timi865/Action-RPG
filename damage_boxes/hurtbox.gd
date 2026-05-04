class_name Hurtbox extends Area2D#by adding a class name you can create a custom node

signal hurt(hitbox: Hitbox)# custom signal

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area_2D: Area2D) -> void:
	if area_2D is not Hitbox: return
	var hitbox = area_2D as Hitbox#gives autocomplete
	if self in hitbox.hit_targets: return# if we are in the list of hit targets in the hitbox then return
	hitbox.hit_targets.append(self)#adds us to the list
	hurt.emit(hitbox)
