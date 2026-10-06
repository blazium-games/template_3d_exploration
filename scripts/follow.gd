extends Node3D

const Rules = preload("res://scripts/rules.gd")
var rules = Rules.new()
var dropped := false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		if not dropped:
			rules.drop_oldest()
			dropped = true
		if rules.store_item("grove_token") == "stored":
			$GroveToken.visible = false
