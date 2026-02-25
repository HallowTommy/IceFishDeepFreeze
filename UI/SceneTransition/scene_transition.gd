extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play_backwards("Transition")
	
func _change_scene(scene_path : String) -> void:
	animation_player.play("Transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(scene_path)
	await get_tree().scene_changed
	animation_player.play_backwards("Transition")
	
func _transition(function : Callable) -> void:
	animation_player.play("Transition")
	await animation_player.animation_finished
	await function.call()
	animation_player.play_backwards("Transition")
	
