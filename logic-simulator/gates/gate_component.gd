extends Node2D

@onready var parent : Node2D = get_parent()

var draggable: bool = true
var dragging: bool = false

func _ready() -> void:
	if parent.identity.gate_label == "":
		$ColorRect.color = Color.STEEL_BLUE
	elif parent.identity.gate_label == "LOW":
		$ColorRect.color = Color.DARK_GRAY.darkened(0.80)
	elif parent.identity.gate_label == "HIGH":
		$ColorRect.color = Color.RED.lightened(0.20)
	$ColorRect/Name.text = parent.identity.gate_label
	draggable = parent.identity.draggable
	queue_redraw()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("redraw"):
		queue_redraw()
	
	if dragging and draggable:
		parent.position = get_global_mouse_position()

func _draw():
	if parent.identity.gate_label == "":
		$ColorRect/Name.text = 'ON' if parent.input_1.output == 1 else 'OFF'
		
	var yShift: float = 0.0 if parent.identity.gate_label == "" else 0.33
	
	if parent.input_1 != null:
		var color = Color.BROWN if parent.input_1.output == 1 else Color.DIM_GRAY
		var loc = Vector2(-1.10 * $ColorRect.size.x, -yShift * $ColorRect.size.y)
		draw_line(loc, parent.input_1.global_position - parent.global_position, color, 3.0)
		draw_primitive([loc + Vector2(0, -10), loc + Vector2(0, 10), loc + Vector2(10, 0)], [color], [])
	if parent.input_2 != null:
		var color = Color.BROWN if parent.input_2.output == 1 else Color.DIM_GRAY
		var loc = Vector2(-1.10 * $ColorRect.size.x, yShift * $ColorRect.size.y)
		draw_line(loc, parent.input_2.global_position - parent.global_position, color, 3.0)
		draw_primitive([loc + Vector2(0, -10), loc + Vector2(0, 10), loc + Vector2(10, 0)], [color], [])

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		dragging = event.pressed
		
		if event.is_released() and not draggable:
			if parent.identity.gate_label == "HIGH":
				$ColorRect.color = Color.DARK_GRAY.darkened(0.80)
				parent.identity.gate_label = "LOW"
				$ColorRect/Name.text = parent.identity.gate_label
				parent.truth_table[Vector2i(0, 0)] = 0
				parent.truth_table[Vector2i(1, 0)] = 0
			elif parent.identity.gate_label == "LOW":
				$ColorRect.color = Color.RED.lightened(0.20)
				parent.identity.gate_label = "HIGH"
				$ColorRect/Name.text = parent.identity.gate_label
				parent.truth_table[Vector2i(0, 0)] = 1
				parent.truth_table[Vector2i(1, 0)] = 1
