extends TextureRect

@onready var hook: TextureRect = %Hook
@onready var string: Line2D = %String
@onready var fish: TextureRect = %Fish
signal money_changed
func _ready() -> void:
	string.scale.y = 0.2
	fish.texture = null
	#_catch()
func _catch(fish_texture) -> void:
	var tween = create_tween().set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(hook, "position:y", hook.position.y + 400, 1.0)
	tween.tween_property(fish, "position:y", fish.position.y + 400, 1.0)
	tween.tween_property(string, "scale:y",1.0, 1.0)
	$SFX/Reel.play()
	await tween.finished
	fish.scale = Vector2(0.205,0.205)
	fish.texture = fish_texture
	var tween2 = create_tween().set_parallel(true)
	tween2.set_ease(Tween.EASE_IN_OUT)
	tween2.set_trans(Tween.TRANS_SINE)
	tween2.tween_property(hook, "position:y", hook.position.y - 400, 1.0)
	tween2.tween_property(string, "scale:y", 0.2, 1.0)
	tween2.tween_property(fish, "position:y", fish.position.y - 400, 1.0)
	$SFX/Catch.play()
	await get_tree().create_timer(0.4).timeout
	get_parent().get_parent().get_parent().emit()
	money_changed.emit()
	$SFX/Prize.play()
	$SFX/Reel.stop()
	await tween2.finished
	$SFX/Reel.stop()
	var tween3 = create_tween().set_parallel(true)
	tween3.set_ease(Tween.EASE_IN_OUT)
	tween3.set_trans(Tween.TRANS_SINE)
	tween3.tween_property(fish, "scale", Vector2.ZERO, 1.0)
	await tween3.finished
