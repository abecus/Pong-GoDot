extends Node2D

onready var ball_speed : float = 200
# warning-ignore:unused_class_variable
onready var pad_speed : int = 250
onready var ball_direction: Vector2 = Vector2(1,0)
var ball_size : Vector2
var pad_size : Vector2
var screen_size : Vector2
signal completed
const directions = [-1,1]  # use to choose the direction of ball when game over
var left_score := 0
var right_score := 0


func _ready() -> void:
	$Counter.hide()
	$Seperator.hide()
	$CanvasLayer/Background.show()
	$ScoreDisplay.hide()
	self.position = screen_size/2
	screen_size = get_viewport().size
	pad_size = Vector2($Left/Sprit.texture.get_size().x,
				$Left/Sprit.texture.get_size().y*1.5)
	ball_size = $Ball/Sprite.texture.get_size()

# warning-ignore:return_value_discarded
	$StartButton.connect("pressed", self, "start")


func start():
	$StartButton.hide()
	$NamePlate.hide()
	$Ball.show()
	$Left.show()
	$Right.show()
	$Seperator.show()
	$ScoreDisplay.show()
	self.reset_position()

func reset_position()->void:
	$Ball.hide()

	$Right.position = Vector2(screen_size.x-10, screen_size.y/2)
	$Left.position = Vector2(10, screen_size.y/2)
	$Ball.position = screen_size/2
	self.ball_direction = Vector2(directions[randi()%directions.size()], 0)
	self.ball_speed = 200.0

	yield(get_tree().create_timer(0.5), "timeout")
	$Counter.text = "3"
	$Counter.show()
	yield(get_tree().create_timer(1.0), "timeout")
	$Counter.text = "2"
	yield(get_tree().create_timer(1.0), "timeout")
	$Counter.text = "1"
	yield(get_tree().create_timer(1.0), "timeout")

	$Counter.hide()
	$Ball.show()
	emit_signal("completed")
