extends Node2D

@onready var parent : Node2D = get_parent()

var dragging: bool = false

var timeDif: float = 0.1

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
	timeDif -= delta
	if timeDif < 0.0:
		queue_redraw()
		timeDif = 0.1
	
	if dragging:
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
		if event.button_index == 2:
			dragging = event.pressed
		
		elif event.button_index == 1 and event.is_released():
			if parent.identity.gate_label == "":
				pass
			
			if parent.identity.gate_label == "HIGH":
				$ColorRect.color = Color.DARK_GRAY.darkened(0.80)
				parent.identity = load("res://gates/power_syms/ground.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "LOW":
				$ColorRect.color = Color.RED.lightened(0.20)
				parent.identity = load("res://gates/power_syms/power.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			
			elif parent.identity.gate_label == "AND":
				parent.identity = load("res://gates/nand/nand.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "NAND":
				parent.identity = load("res://gates/or/or.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "OR":
				parent.identity = load("res://gates/nor/nor.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "NOR":
				parent.identity = load("res://gates/xor/xor.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "XOR":
				parent.identity = load("res://gates/xnor/xnor.tres")
				$ColorRect/Name.text = parent.identity.gate_label
			elif parent.identity.gate_label == "XNOR":
				parent.identity = load("res://gates/and/and.tres")
				$ColorRect/Name.text = parent.identity.gate_label
