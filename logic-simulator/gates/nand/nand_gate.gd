extends Node2D

@export var identity : Identity

@export var input_1 : Node2D
@export var input_2 : Node2D

var output : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	set_output()

func set_output():
	var in_1_val : int = input_1.output if input_1 != null else 0
	var in_2_val : int = input_2.output if input_2 != null else 0
	output = identity.truth_table[Vector2i(in_1_val, in_2_val)]
