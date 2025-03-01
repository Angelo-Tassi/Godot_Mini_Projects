extends Area2D
class_name Gem
signal on_gem_offscreen 

@export var speed: float = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed * delta
	
	if position.y > get_viewport_rect().size.y:
		on_gem_offscreen.emit()
		set_process(false)
		queue_free()


func _on_on_gem_offscreen() -> void:
	pass # Replace with function body.
