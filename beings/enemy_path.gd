extends Path2D

@export var move_ratio: float = 0.20

@onready var path_follow: PathFollow2D = $PathFollow2D

func create_path() -> void:
	var points: PackedVector2Array = []

	# TODO: randomize
	var zigzag_amplitude: float = 40.0  # How far to zig-zag from the main line
	var zigzag_frequency: float = 5    # How frequent the zig-zags are
	var curve_length: float = 800.0     # How long the curve is (including extension beyond the target)
	var segments: int = 100             # Number of segments in the curve

	# Get player position for target point
	var target_point: Vector2 = get_tree().get_first_node_in_group("Player").global_position

	var start_point: Vector2 = position

	# Direction vector form the start to the target
	var direction: Vector2 = (target_point - start_point).normalized()

	for i: int in range(segments):
		# Calculate the linear position along the curve
		var t: float = float(i) / float(segments) # Normalized value from 0 to 1
		var point_on_line: Vector2 = Vector2(0,0)+direction*curve_length*t # Curve paths origin are local, so start at 0,0

		# Add zig-zagging effect by offsetting perpendicular to the direction
		var perpendicular: Vector2 = Vector2(-direction.y, direction.x)
		var zigzag_offset: Vector2 = perpendicular*sin(t*TAU*zigzag_frequency)*zigzag_amplitude

		# Final zig-zagging point
		var final_point: Vector2 = point_on_line + zigzag_offset
		points.append(final_point)
		self.curve.add_point(final_point)

func _ready() -> void:
	create_path()

func _process(delta: float) -> void:
	path_follow.progress_ratio += move_ratio*delta
	if path_follow.progress_ratio >= 1 or path_follow.get_child_count() == 0:
		queue_free()
