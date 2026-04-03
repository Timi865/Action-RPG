class_name Player extends CharacterBody2D

const SPEED = 100.0
const ROLL_SPEED = 150

var input_vector: = Vector2.ZERO#by putting this variable at the top this means that i can use it in all functions
var last_input_vector: = Vector2.ZERO

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(_delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"MoveState": move_state(_delta)
		"AttackState":pass
		"RollState": roll_state(_delta)
			

func move_state(delta: float) -> void:
	input_vector = Input.get_vector("move_left","move_right", "move_up", "move_down")#This is movement
			
	if input_vector != Vector2.ZERO:
		last_input_vector = input_vector
		var direction_vector: = Vector2(input_vector.x, -input_vector.y)
		update_blend_positions(direction_vector)
		
	if Input.is_action_just_pressed("attack"):
		playback.travel("AttackState")
		
	if Input.is_action_just_pressed("roll"):
		playback.travel("RollState")
	
	velocity = input_vector * SPEED
	move_and_slide()
 
func roll_state(delta: float) -> void:
	velocity = last_input_vector.normalized() * ROLL_SPEED
	move_and_slide()

func update_blend_positions(direction_vector: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/RunState/blend_position", input_vector)
	animation_tree.set("parameters/StateMachine/MoveState/StandState/blend_position", input_vector)
	animation_tree.set("parameters/StateMachine/AttackState/blend_position", input_vector)
	animation_tree.set("parameters/StateMachine/RollState/blend_position", input_vector)
