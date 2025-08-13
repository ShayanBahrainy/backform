extends Node2D

var CURRENT_DIR = 1

var BORDER_ONE = -2168
var BORDER_TWO = -4300

var MOVE_INCREMENT = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if CURRENT_DIR < 0:
		$Sprite2D.flip_h = false
	if CURRENT_DIR > 0:
		$Sprite2D.flip_h = true
	if position.x > BORDER_ONE || position.x < BORDER_TWO:
		CURRENT_DIR *= -1
	position.x += MOVE_INCREMENT * delta * CURRENT_DIR


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		GameController.got_eaten()
