extends Node

const FILE_PATH: String = "user://Data.json"
var bought_fishing_rods : Array[bool] = [false,false,false,false,false,false,false,false]
var current_equipped_rod : int = 0
var save_data: Dictionary = {
	"Money" : 1000000,
	"Luck" : 0.0,
	"CAN_VIBRATE" : true,
	"SFX" : 50.0,
	"Music" : 50.0,
	"Shop" : bought_fishing_rods,
	"Rod" : current_equipped_rod,
}
func _ready() -> void:
	_load()

#region Save-Load
func _save() -> void:
	var file : FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH, FileAccess.WRITE,"9f3c2a1d8e4b7f6a5d0e91c8b2a3476c5e8d0f1a9b4c7e2d6a3f8b1c0e4")
	file.store_var(save_data)
	file.close()
func _load() -> void:
	if FileAccess.file_exists(FILE_PATH):
		var file : FileAccess = FileAccess.open_encrypted_with_pass(FILE_PATH, FileAccess.READ,"9f3c2a1d8e4b7f6a5d0e91c8b2a3476c5e8d0f1a9b4c7e2d6a3f8b1c0e4")
		var data : Dictionary = file.get_var()
		for i in data:
			if save_data.has(i):
				save_data[i] = data[i]
		file.close()
#endregion
