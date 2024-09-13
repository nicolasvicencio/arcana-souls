extends Area2D

@export var damage: int = 1
@onready var disabled_timer: Timer = $disabled_timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func tempdisabled(damage):
	collision_shape_2d.set_deferred("disabled", true)
	disabled_timer.start()

func _on_disabled_timer_timeout() -> void:
	collision_shape_2d.set_deferred("disabled", false)
	
