extends CharacterBody2D

const SPEED = 200
var max_health = 10
var current_health = max_health
@onready var player_animations: AnimatedSprite2D = $AnimatedSprite2D
@onready var gun: Area2D = $Gun
@onready var shootgun: Area2D = $Shootgun
@onready var ak_47: Area2D = $"Ak-47"
@onready var bazooka: Area2D = $Bazooka

signal healthChanged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	manage_input(delta)
	handle_animations(delta)
	move_and_slide()
	
func manage_input(delta:float):
	var input_axis = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if Input.is_action_pressed("action"):
		shoot()
	if input_axis:
		velocity = lerp(velocity, SPEED * input_axis, 1)
		player_animations.play("run")
	elif input_axis.x == 0 && input_axis.y == 0:
		velocity = Vector2.ZERO
		player_animations.play("idle")
	
func handle_animations(delta:float):
	var input_axis = Input.get_axis("move_left", "move_right")
	if input_axis < 0 :
		player_animations.flip_h = true
	elif input_axis > 0 :
		player_animations.flip_h = false
	
func shoot():
	gun.set_spawn_point(player_animations.position)
	gun.shoot(250, gun.rotation_degrees)

func _on_hurtbox_hurt(damage: Variant) -> void:
	current_health = current_health - damage
	print("hi")
	healthChanged.emit()
	
