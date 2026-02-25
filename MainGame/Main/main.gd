extends Node2D

var luck : float = 0.0
@onready var marker: Control = %Marker
@onready var mask: TextureRect = %Mask
@onready var points: GPUParticles2D = %Points
@onready var money_label: Label = %MoneyLabel

var money : int = 0
var red : float = 0.0
var orange : float = 0.0
var blue : float = 0.0

var _points = [ # chances
	{"b":0.90, "o":0.10, "r":0.00},
	{"b":0.80, "o":0.15, "r":0.05},
	{"b":0.70, "o":0.22, "r":0.08},
	{"b":0.60, "o":0.28, "r":0.12},
	{"b":0.50, "o":0.35, "r":0.15},
	{"b":0.40, "o":0.40, "r":0.20},
	{"b":0.32, "o":0.42, "r":0.26},
	{"b":0.25, "o":0.45, "r":0.30},
]
@export var fish_info : Dictionary = {
	"Blue" : [blue, 25], # [ Chance, Points ]
	"Orange" : [orange, 50],
	"Red" : [red, 75]
}

func _ready() -> void:
	Global._load()
	_update_money()
	mask.money_changed.connect(_update_money)
	%Shop.shop_items._update_money.connect(_update_money)
	%Shop.shop_items._update_rarities.connect(_update_rarities)
	$UI/Hint2.hide()
	_update_rarities()
	
var can_catch : bool = true
var opened : bool = false
var can_vibrate : bool = false
enum Rarity { BLUE, ORANGE, RED }

func _on_catch_fish_pressed() -> void:
	if not opened:
		$UI/Hint2.show()
		$AnimationPlayer.play("Hint2")
	$UI/Hint.hide()
	if not can_catch: return
	match pick_rarity():
		Rarity.BLUE:
			#print("BLUE")
			_update_data("Blue")
		Rarity.ORANGE:
			#print("ORANGE")
			_update_data("Orange")
		Rarity.RED:
			#print("RED")
			_update_data("Red")
			
func pick_rarity() -> Rarity:
	# Safety: normalize in case of float drift
	var total := blue + orange + red
	blue /= total
	orange /= total
	red /= total

	var roll := randf()

	if roll < red:
		return Rarity.RED
	elif roll < red + orange:
		return Rarity.ORANGE
	else:
		return Rarity.BLUE
func _update_data(key) -> void:
	can_catch = false
	var money_amount = fish_info.get(key)[1]
	money += money_amount
	Global.save_data["Money"] += money_amount
	Global._save()
	var fish_texture := load("res://Assets/Fish/" + key + ".png")
	var money_texture := load("res://Assets/Points/" + str(money_amount) + ".png")
	points.texture =money_texture
	await mask._catch(fish_texture)
	can_catch = true
func _update_rarities() -> void:
	luck = Global.save_data["Luck"]
	luck *=7
	blue = _points[int(luck)].get("b")
	orange = _points[int(luck)].get("o")
	red = _points[int(luck)].get("r")
	fish_info = {
	"Blue" : [blue, 25], # [ Chance, Points ]
	"Orange" : [orange, 50],
	"Red" : [red, 75]
	}
	print(fish_info)
	print(Global.save_data["Luck"])
func _on_shop_pressed() -> void:	
	$UI/Hint2.hide()
	SceneTransition._transition(%Shop.show)
	opened = true
func _on_stats_pressed() -> void:
	%Stats.show()
func emit() -> void:
	points.emitting = true
	Global._save()
func _update_money() -> void:
	money_label.text = str(Global.save_data.get("Money"))


func _on_settings_pressed() -> void:
	SceneTransition._transition(%Settings.show)
