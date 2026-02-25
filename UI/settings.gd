extends VBoxContainer

func _ready() -> void:
	#Global._load()
	#if Global.save_data["CAN_VIBRATE"]:
		#$HBoxContainer/Vibration.button_pressed = true
	Global._load()
	$SFX.value = Global.save_data["SFX"]
	$Music.value = Global.save_data["Music"]
	
#func _on_vibration_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#Global.save_data["CAN_VIBRATE"] = true
		#Global._save()
	#else:
		#Global.save_data["CAN_VIBRATE"] = false
		#Global._save()
		#


func _on_back_pressed() -> void:
	Global.save_data["Music"] = $Music.value
	Global.save_data["SFX"] = $SFX.value
	Global._save()
	SceneTransition._transition(get_parent().get_parent().hide)


func _on_music_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(2,value / 5)
func _on_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(1,value / 5)
