extends Node2D
const PIPES = preload("res://scenes/pipes/Pipes.tscn")

@onready var marker_2d_up: Marker2D = $Marker2D_up
@onready var marker_2d_2_down: Marker2D = $Marker2D2_down
@onready var pipes_spawn_timer: Timer = $Pipes_Spawn_Timer
@onready var pipes_container: Node = $Pipes_Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_plane_died.connect(on_plane_died)
	spawn_pipes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func spawn_pipes() -> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var pipes_position_y :float = randf_range(marker_2d_up.position.y, marker_2d_2_down.position.y)
	new_pipes.position = Vector2 (marker_2d_2_down.position.x, pipes_position_y)
	pipes_container.add_child(new_pipes)


func spawn_timer_timeout() -> void:
	spawn_pipes()


func on_plane_died() -> void:
	pipes_spawn_timer.stop()
