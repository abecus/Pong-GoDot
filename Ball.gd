extends Area2D

func _ready() -> void:
	self.hide()
	get_node("..").connect("completed", self, "init_done")
	set_process(false)

func init_done():
	set_process(true)

func _process(delta: float) -> void:
	# get all position of the sprits (balls, left_pad, right_pad).
	var pos = self.get_position()+ get_node("..").ball_speed* delta* 			get_node("..").ball_direction

	# checks for if ball is at roof or floor and changing it's direction
	if not (0<pos.y and pos.y<get_node("..").screen_size.y):
		get_node("..").ball_direction.y *= -1

	self.position = pos

	if not (0<pos.x and pos.x<get_node("..").screen_size.x):
		get_node("..").reset_position()
		set_process(false)