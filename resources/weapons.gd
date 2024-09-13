extends Area2D
class_name Weapon

@export var bullet: PackedScene
@export_range(1,999) var number_bullets: int = 1
@export var cooldown: float = 0.1
@export_range(0,200) var angle_variation: int = 0
@export_range(1,180)var shoot_arc: int = 1
@export var spawn_point: Vector2

var spawn_point_node: Marker2D
var timer: Timer

func set_number_bullets(n_bullets: int):
	number_bullets = n_bullets
func get_number_bullets():
	return number_bullets
	
func set_cooldown(n_cooldown:float):
	cooldown = n_cooldown
	timer.wait_time = n_cooldown 
func get_cooldown():
	return cooldown

func set_angle_variation(n_angle_variation: int):
	angle_variation = n_angle_variation
func get_angle_variation():
	return angle_variation

func set_shoot_arc(n_shoot_arc: int):
	shoot_arc = n_shoot_arc
func get_shoot_arch():
	return shoot_arc

func set_spawn_point(n_spawn_point: Vector2):
	spawn_point = n_spawn_point
func get_spawn_point():
	return spawn_point

func can_shoot():
	return timer.is_stopped()

func shoot(speed=200, angle=0.0):
	if can_shoot():
		if number_bullets == 1:
			var new_bullet = bullet.instantiate()
			new_bullet.global_position = spawn_point_node.global_position
			new_bullet.top_level = true
			new_bullet.speed = speed
			if angle != -1:
				new_bullet.angle = angle + randi_range(angle_variation, -angle_variation)
			else:
				new_bullet.angle = rotation_degrees + randi_range(angle_variation, -angle_variation)
			add_child(new_bullet)
		elif number_bullets >= 2:
			var angle_increment = shoot_arc / (number_bullets -1 )
			var start_angle
			if angle != -1:
				start_angle = angle - (shoot_arc / 2)
			else:
				start_angle = rotation_degrees - (shoot_arc / 2)
			for i in number_bullets:
				var new_bullet = bullet.instantiate()
				new_bullet.global_position = spawn_point_node.global_position
				new_bullet.top_level = true
				new_bullet.speed = speed
				new_bullet.angle = (start_angle + (angle_increment * i )) + randi_range(angle_variation, -angle_variation)
				add_child(new_bullet)
		timer.start()	
			
		
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cd_timer = Timer.new()
	cd_timer.wait_time = cooldown
	cd_timer.one_shot = true
	timer = cd_timer
	add_child(cd_timer)
	
	var cd_spawn_point = Marker2D.new()
	cd_spawn_point.position = spawn_point
	spawn_point_node = cd_spawn_point
	add_child(cd_spawn_point)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !Engine.is_editor_hint():
		pass
	else:
		pass
	queue_redraw()
