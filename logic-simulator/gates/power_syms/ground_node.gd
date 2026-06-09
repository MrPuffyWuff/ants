extends Node2D

@export var identity : Identity

@export var input_1 : Node2D
@export var input_2 : Node2D

var truth_table: Dictionary[Vector2i, int] = {Vector2i(0, 0): 0, Vector2i(1, 0): 0}

var output : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	set_output()

func set_output():
	await get_tree().create_timer(randf_range(0.0, 0.2))
	var in_1_val : int = input_1.output if input_1 != null else 0
	var in_2_val : int = input_2.output if input_2 != null else 0
	output = truth_table[Vector2i(in_1_val, in_2_val)]
