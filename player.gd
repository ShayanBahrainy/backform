class_name Player extends CharacterBody2D

const SPEED = 450.0
const JUMP_VELOCITY = -600.0

enum CurrentAnimation{None, Scale, Shrink}
var ca: CurrentAnimation

const ShrunkNum = 1
const ScaledNum = 0.5

const CameraIncrement = 0.2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if velocity.x < -100:
		$Sprite2D.flip_h = false
	if velocity.x > 100:
		$Sprite2D.flip_h = true
	if ca == CurrentAnimation.Scale:
		if $Camera2D.zoom.x > ScaledNum:
			$Camera2D.zoom.x += CameraIncrement * delta * -1
			$Camera2D.zoom.y += CameraIncrement * delta * -1
		if $Camera2D.zoom.x <= ScaledNum:
			ca = CurrentAnimation.None
	if ca == CurrentAnimation.Shrink:
		if $Camera2D.zoom.x < ShrunkNum:
			$Camera2D.zoom.x += CameraIncrement * delta
			$Camera2D.zoom.y += CameraIncrement * delta
		if $Camera2D.zoom.x >= ShrunkNum:
			ca = CurrentAnimation.None
	move_and_slide()

func start_shrink():
	ca = CurrentAnimation.Shrink
func start_scale():
	ca = CurrentAnimation.Scale
