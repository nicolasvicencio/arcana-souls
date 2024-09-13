extends TextureProgressBar

@onready var player: CharacterBody2D = $"../../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	player.healthChanged.connect(update)

func update():
	value = player.current_health * 100 / player.max_health
