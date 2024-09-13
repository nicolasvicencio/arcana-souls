extends Weapon 
var m_pos
var pos 
var rot
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	m_pos = get_global_mouse_position()
	pos = global_position
	look_at(m_pos) 
	
	rot = rad_to_deg((m_pos - pos).angle())  
	if rot >= -90 && rot <=90:
		sprite_2d.flip_v = false
	else:
		sprite_2d.flip_v = true
