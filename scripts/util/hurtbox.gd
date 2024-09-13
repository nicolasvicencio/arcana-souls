extends Area2D

@export_enum("Cooldown", "HitOnce", "DisabledHitbox") var HurtboxType = 0
@onready var disabled_timer: Timer = $disabled_timer

signal hurt(damage)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		if area.get("damage") != null:
			match HurtboxType:
				0:#Cooldown
					$CollisionShape2D.set_deferred("disabled", true)
					disabled_timer.start()
				1:#HitOnce
					pass
				2:#DisabledHitbox
					if area.has_method("tempdisabled"):
						area.tempdisabled()
			var damage = area.damage
			emit_signal("hurt", damage)
					


func _on_disabled_timer_timeout() -> void:
	$CollisionShape2D.set_deferred("disabled", false)
