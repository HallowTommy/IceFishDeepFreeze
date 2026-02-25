extends MarginContainer

var rod_data : Rod
@onready var button: Button = %Buy
@onready var item_name: Label = %Name
@onready var texture: TextureRect = %Texture
@onready var cost: Label = %Cost
@onready var info: RichTextLabel = %Info
var index : int = 0
var bought : bool = false
var equipped : bool = false
func _update_data() -> void:
	item_name.text = rod_data.item_name
	texture.texture = rod_data.texture
	cost.text = str(rod_data.cost)
	info.text = rod_data.info
signal equip
func _set_margins(left : int = 90,right : int = 90) -> void:
	add_theme_constant_override("margin_left", left)
	add_theme_constant_override("margin_right", right)


func _on_buy_pressed() -> void:
	if bought:
		Global.save_data["Luck"] = rod_data.luck
		cost.text = "Equipped"
		equip.emit(self)
		#get_parent().current_equipped = self
		Global.save_data.set("Rod", index)
		Global._save()
		return
	var current_money = Global.save_data.get("Money")
	if current_money >= rod_data.cost:
		var bought_items = Global.save_data.get("Shop")
		bought_items[index] = true
		Global.save_data.set("Money", current_money - rod_data.cost)
		get_parent()._update_money.emit()
		_update()
		cost.text = "Equipped"
		Global.save_data["Luck"] = rod_data.luck
		equip.emit(self)
		#get_parent().current_equipped = self
		Global.save_data.set("Rod", index)
		Global._save()
		bought = true

func _update() -> void:
	var normal : StyleBoxTexture = StyleBoxTexture.new()
	normal.texture = load("res://UI/Sprites/Equip.png")
	var pressed : StyleBoxTexture = StyleBoxTexture.new()
	pressed.texture = load("res://UI/Sprites/Equipped.png")
	button.add_theme_stylebox_override("hover",normal)
	button.add_theme_stylebox_override("normal",normal)
	button.add_theme_stylebox_override("pressed",pressed)
	cost.text = "Equip"
	if Global.save_data.get("Rod") == index:
		cost.text = "Equipped"
		
func unequip() -> void:
	cost.text = "Equip"
	
