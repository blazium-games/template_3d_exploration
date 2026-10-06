extends AutoworkTest

const Rules = preload("res://scripts/rules.gd")

func test_first_and_duplicate() -> void:
	var rules = Rules.new()
	assert_eq(rules.store_item("token"), "stored", "first")
	assert_eq(rules.store_item("token"), "duplicate", "again")

func test_full_pack() -> void:
	var rules = Rules.new()
	for i in 4:
		assert_eq(rules.store_item("item-%d" % i), "stored", "slot")
	assert_eq(rules.store_item("extra"), "full", "fifth rejected")
	assert_eq(rules.store_item(""), "blank", "blank id")
	assert_eq(rules.drop_oldest(), "dropped", "room")
	assert_eq(rules.store_item("extra"), "stored", "fifth after drop")

func test_grove_gate() -> void:
	var rules = Rules.new()
	assert_false(rules.may_grove(), "empty pack")
	assert_eq(rules.store_item("token"), "stored", "first")
	assert_true(rules.may_grove(), "can leave")
	assert_eq(rules.store_item("token"), "duplicate", "same item")
	assert_true(load("res://scenes/grove.tscn") != null, "grove loads")
