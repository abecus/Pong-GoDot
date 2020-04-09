extends Area2D


func _ready() -> void:
	self.hide()
	self.connect("area_entered", self, "change_ball_direction")


func _process(delta: float) -> void:

	var player = get_name()
	var pos = self.get_position()

	if pos.y>get_node("..").pad_size.y/2 and Input.is_action_pressed(player+"_up"):
		pos.y += -get_node("..").pad_speed *delta

	if pos.y<get_node("..").screen_size.y-get_node("..").pad_size.y/2 and Input.is_action_pressed(player+"_down"):
		pos.y += get_node("..").pad_speed*delta

	self.set_position(pos)


func change_ball_direction(area: Area2D):
	if area.get_name() == "Ball":
		get_node("..").ball_direction = Vector2(-get_node("..").ball_direction.x, randf() * 2 - 1).normalized()
		get_node("..").ball_speed *= 1.1