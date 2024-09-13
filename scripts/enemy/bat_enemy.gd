extends CharacterBody2D

const SPEED = 30
var hp = 20
var player 
var target_position
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
# Called every frame. 'delta' is the elapsed time since the previaous frame.
func _process(delta: float) -> void:
	target_position = (player.position - position).normalized()
	velocity = target_position * SPEED
	move_and_slide()

func _on_hurtbox_hurt(damage: Variant) -> void:
	var tween = create_tween()
	tween.tween_method(setShader_Blink, 1.0, 0.0, 0.5)
	$CPUParticles2D.emitting = true
	hp = hp - damage
	print("enemy", hp)
	if hp <= 0:
		queue_free()

func setShader_Blink(new_value: float):
	$AnimatedSprite2D.material.set_shader_parameter("blink_intensity", new_value)
