extends Node2D
const EXPLODE = preload("res://assets/explode.wav")
@export var gem_scene: PackedScene 
var _score: int = 0
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_gem() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func spawn_gem() -> void:
	var new_gem :Gem = gem_scene.instantiate()
	var xpos : float = randf_range(70, 1050)
	new_gem.on_gem_offscreen.connect(game_over)
	new_gem.position = Vector2(xpos, -70)
	add_child(new_gem)
	
func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func play_dead() -> void:
	audio_stream_player_2d_2.stop()
	audio_stream_player_2d.stop()
	audio_stream_player_2d_2.stream = EXPLODE
	audio_stream_player_2d_2.play()

	
func game_over() ->  void:
	stop_all()
	play_dead()

func _on_timer_timeout() -> void:
	spawn_gem()
	print ("_on_timer_timeout")

func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	label.text = "Score: %05d" % _score
	audio_stream_player_2d_2.position =area.position
	audio_stream_player_2d_2.play()
	area.queue_free()
