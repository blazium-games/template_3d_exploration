extends RefCounted

const LIMIT := 4
var slots: Array[String] = []
var seen: Dictionary = {}

func store_item(item_id: String) -> String:
	if item_id.strip_edges() == "":
		return "blank"
	if seen.has(item_id):
		return "duplicate"
	if slots.size() >= LIMIT:
		return "full"
	slots.append(item_id)
	seen[item_id] = true
	return "stored"

func drop_oldest() -> String:
	if slots.is_empty():
		return "empty"
	var old: String = slots[0]
	slots.remove_at(0)
	seen.erase(old)
	return "dropped"

func reset_pack() -> void:
	slots.clear()
	seen.clear()

func may_grove() -> bool:
	return slots.size() >= 1
