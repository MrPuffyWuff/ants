extends Resource

class_name Identity

@export var gate_label : String = "Unnamed"
@export var truth_table : Dictionary[Vector2i, int] = {
	Vector2i(1,0) : 1,
	Vector2i(0,0) : 0,
}
