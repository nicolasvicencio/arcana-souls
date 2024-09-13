extends Weapon

var m_pos 
var pos
var rot

func _physics_process(delta: float) -> void:
	var m_pos = get_global_mouse_position()
	var pos = global_position
	look_at(m_pos)
	var rot = rad_to_deg((m_pos - pos).angle())
	
	if rot >= 90 && rot <= -90:
		$Sprite2D.flip_v = false
	else:
		$Sprite2D.flip_v = true
