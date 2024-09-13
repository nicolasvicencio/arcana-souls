extends Area2D
class_name Bullet

@export var delete_after: int = 30
var speed: float
var angle: float

var time = 0

func _ready() -> void:
	if delete_after == 0 :
		var screen_checker = VisibleOnScreenNotifier2D.new()
		add_child(screen_checker)
		screen_checker.connect("screen_exited()", on_screen_exited)

func _physics_process(delta: float) -> void:
	rotation_degrees = angle
	position += (Vector2.from_angle(rotation) * speed) * delta
	if delete_after > 0:
		time += delta
		if time >= delete_after:
			queue_free()

func on_screen_exited():
	queue_free()
