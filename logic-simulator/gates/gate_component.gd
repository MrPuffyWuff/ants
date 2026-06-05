extends Node2D

@onready var parent : Node2D = get_parent()

func _ready() -> void:
	$ColorRect/Name.text = parent.identity.gate_label
	queue_redraw()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("redraw"):
		queue_redraw()

func _draw():
	if parent.input_1 != null:
		var color = Color.RED if parent.input_1.output == 1 else Color.BLACK
		draw_line(Vector2.ZERO, parent.input_1.global_position - parent.global_position, color, 2.0)
	if parent.input_2 != null:
		var color = Color.RED if parent.input_2.output == 1 else Color.BLACK
		draw_line(Vector2.ZERO, parent.input_2.global_position - parent.global_position, color, 2.0)
