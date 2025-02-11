extends Node2D

class_name Pipes

const OFF_SCREEN: float = -500.0
@onready var score_sound: AudioStreamPlayer = $ScoreSound


func _ready() -> void:
	SignalManager.on_plane_died.connect(on_plane_died)
	SignalManager._on_pipe_body_entered.connect(_on_pipe_body_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= GameManager.SCROLL_SPEED * delta
	
func off_screen () -> void:
	if position.x < 500.0 :
		queue_free()


func notifier_screen_exited() -> void:
	queue_free()

func on_plane_died() -> void:
	set_process(false)
	


func _on_pipe_body_entered(body: Node2D) -> void:
	#TWO METHODS
	#USING CLASS_NAME PLANE ON THE PLANE SCENE TO DEFINE THE CLASS
	if body is plane:
		body.die()
	#USING GLOBAL GROUP TO DEFINE THE PLANE(PRE-ASSIGNED to GROUP)
	#if body.is_in_group(GameManager.GROUP_PLANE) == true:
		#if body.has_method ("die") == true:
			#body.die()


func _on_laser_body_entered(body: Node2D) -> void:
	if body is plane:
		score_sound.play()
