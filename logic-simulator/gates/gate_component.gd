extends Node2D

@onready var parent : Node2D = get_parent()

var dragging: bool = false

func _ready() -> void:
	if parent.identity.gate_label == "":
		$ColorRect.color = Color.STEEL_BLUE
	elif parent.identity.gate_label == "LOW":
		$ColorRect.color = Color.DARK_GRAY.darkened(0.80)
	elif parent.identity.gate_label == "HIGH":
		$ColorRect.color = Color.RED.lightened(0.20)
	$ColorRect/Name.text = parent.identity.gate_label
	queue_redraw()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("redraw"):
		queue_redraw()
	
	if dragging:
		parent.position = get_global_mouse_position()

func _draw():
	if parent.identity.gate_label == "":
		if parent.input_1.output == 1:
			$ColorRect/Name.text = 'ON'
		else:
			$ColorRect/Name.text = 'OFF'
	
	if parent.input_1 != null:
		var color = Color.BROWN if parent.input_1.output == 1 else Color.DIM_GRAY
		draw_line(Vector2(-1 * $ColorRect.size.x, 0), parent.input_1.global_position - parent.global_position, color, 3.0)
	if parent.input_2 != null:
		var color = Color.BROWN if parent.input_2.output == 1 else Color.DIM_GRAY
		draw_line(Vector2(-1 * $ColorRect.size.x, 0), parent.input_2.global_position - parent.global_position, color, 3.0)

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		dragging = event.pressed
