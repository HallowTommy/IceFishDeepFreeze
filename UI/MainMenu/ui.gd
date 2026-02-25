extends CanvasLayer

@onready var money_label: Label = %MoneyLabel

func _ready() -> void:
	Global._load()
	_update_money()
	%Shop.shop_items._update_money.connect(_update_money)
func _update_money() -> void:
	money_label.text = str(Global.save_data.get("Money"))
