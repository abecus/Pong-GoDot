extends Node2D

onready var ball_speed : float = 200
onready var pad_speed : int = 250
onready var ball_direction: Vector2 = Vector2(1,0)
var pad_size : Vector2
var screen_size : Vector2
signal completed


func _ready() -> void:
	$Seperator.hide()
	self.position = screen_size/2
	screen_size = get_viewport().size
	pad_size = Vector2($Left/Sprit.texture.get_size().x,
				$Left/Sprit.texture.get_size().y*1.5)
	$StartButton.connect("button_down", self, "_start")


func _start():
	$NamePlate.hide()
	$Ball.show()
	$Left.show()
	$Right.show()
	$Seperator.show()
	$StartButton.hide()
	self.reset_position()

func reset_position()->void:
	$Right.position = Vector2(screen_size.x-10, screen_size.y/2)
	$Left.position = Vector2(10, screen_size.y/2)
	$Ball.position = screen_size/2
	self.ball_direction = Vector2(-1, 0)
	self.ball_speed = 200.0
	yield(get_tree().create_timer(2.0), "timeout")
	emit_signal("completed")
