extends HBoxContainer

func _equip(item) -> void:
	for shop_item in get_children():
		if shop_item.index == Global.save_data.get("Rod") && shop_item != item:
			shop_item.unequip()
	_update_rarities.emit()
signal _update_money
signal _update_rarities
