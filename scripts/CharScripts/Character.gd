class_name Player
extends CharacterBody2D

const SPEED = 150.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var anim_tree: AnimationTree = $AnimationTree

var last_direction: Vector2 = Vector2.DOWN
var target_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	target_position = global_position

func _physics_process(_delta: float) -> void:
	move_to_mouse_position()

func move_to_mouse_position():
	var is_changed_direction: bool = false
	# Lấy input từ chuột
	if Input.is_action_just_pressed("move_to_point"):
		target_position = get_global_mouse_position()
		is_changed_direction = true;
	
	# Tính đường di chuyển nhân vật
	var direction_to_target = target_position - global_position
	
	# Nếu độ lệch nhỏ hơn epsilon thì coi như đã đến vị trí đích và đúng yên (idle)
	if (direction_to_target.length() < GameSettings.MOVEMENT_DEADZONE):
		direction_to_target = Vector2.ZERO
		velocity = direction_to_target
		play_idle_animation(last_direction)
		return
	
	# Tính toán độ dài đường di chuyển trong map bằng cách scale theo hệ số
	var scaled_direction = Vector2(direction_to_target.x / GameSettings.X_SCALE_FACTOR, direction_to_target.y / GameSettings.Y_SCALE_FACTOR)
		
	# Tính toán nhân tố scale tốc độ di chuyển dựa trên đường đi hiển thị và đường đi trong map
	var SPEED_SCALE_FACTOR = direction_to_target.length() / scaled_direction.length()
	
	# Chuẩn hóa đường đi thành hướng di chuyển và tính vận tốc
	direction_to_target = direction_to_target.normalized()
	velocity = direction_to_target * SPEED * SPEED_SCALE_FACTOR
	
	# Chạy Animation chỉ khi chuyển hướng thay đổi đích gốc
	if is_changed_direction:
		last_direction = direction_to_target
		play_run_animation(last_direction)
	
	move_and_slide()

func play_run_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("run_right")
		elif direction.x < 0:
			animated_sprite.play("run_left")
	elif direction.y > 0:
		animated_sprite.play("run_down")
	elif direction.y < 0:
		animated_sprite.play("run_up")

func play_idle_animation(direction: Vector2):
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			animated_sprite.play("idle_right")
		elif direction.x < 0:
			animated_sprite.play("idle_left")
	elif direction.y > 0:
		animated_sprite.play("idle_down")
	elif direction.y < 0:
		animated_sprite.play("idle_up")
