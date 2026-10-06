extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var taken := false

@onready var walker: CharacterBody3D = $Walker
@onready var orbit_eye: Camera3D = $OrbitEye
@onready var token: MeshInstance3D = $Token

func _physics_process(_delta: float) -> void:
	var wish := Vector2(
		Input.get_action_strength("stride_east") - Input.get_action_strength("stride_west"),
		Input.get_action_strength("stride_south") - Input.get_action_strength("stride_north")
	)
	walker.velocity.x = wish.x * 4.0
	walker.velocity.z = wish.y * 4.0
	if not walker.is_on_floor():
		walker.velocity.y -= 12.0 * _delta
	walker.move_and_slide()
	orbit_eye.look_at(walker.global_position)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary") and not taken:
		if rules.store_item("token") == "stored":
			taken = true
			token.visible = false
			if rules.may_grove():
				_go("res://scenes/grove.tscn")

func _go(next_path: String) -> void:
	get_tree().change_scene_to_file(next_path)
