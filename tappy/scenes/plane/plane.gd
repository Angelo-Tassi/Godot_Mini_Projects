extends CharacterBody2D

class_name plane

const GRAVITY: float = 300.0
const POWER: float = - 200

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $CollisionShape2D/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	fly()
	move_and_slide()
	if is_on_floor() == true:
		die()
	
func fly() -> void:
	if Input.is_action_just_pressed("Fly") == true:
		velocity.y = POWER
		animation_player.play("power")

func die() -> void:
	animated_sprite_2d.stop()
	set_physics_process(false)
	SignalManager.on_plane_died.emit()
	
