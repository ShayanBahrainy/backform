extends Node

const MESSAGE_TIME := 2
func bad_food_eaten():
	get_node("/root/Node/CanvasLayer/Panel/Label").text = "Yuck! Try again."
	await get_tree().create_timer(MESSAGE_TIME).timeout
	get_tree().reload_current_scene()
func got_eaten():
	get_node("/root/Node/CanvasLayer/Panel/Label").text = "You got eaten :("
	get_node("/root/Node/Player/Sprite2D").visible = false
	await get_tree().create_timer(MESSAGE_TIME).timeout
	get_tree().reload_current_scene()
func win():
	get_node("/root/Node/CanvasLayer/Panel/Label").text = "You win :) \nThanks for playing!"
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()

func _ready() -> void:
	var whale2 = get_node("/root/Node/Whale2")
	whale2.BORDER_TWO = 300
	whale2.BORDER_ONE = 4600
	whale2.MOVE_INCREMENT = 550 
func _on_home_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		var player = body as Player
		player.start_shrink()


func _on_home_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body is Player:
		var player = body as Player
		player.start_scale()
