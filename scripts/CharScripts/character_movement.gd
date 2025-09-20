extends Node2D

@onready var player: Player = get_owner()
@onready var target_position: Vector2 = player.global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_to_mouse_position(delta)

func move_to_mouse_position(delta: float):
	if player.is_attacking:
		target_position = player.global_position
		player.is_moving = false
		return
	
	var is_target_changed = false
	
	# Lấy input từ chuột, cập nhật hướng di chuyển
	if Input.is_action_just_pressed("move_to_point"):
		target_position = get_global_mouse_position()
		is_target_changed = true
	
	# Tính đường di chuyển nhân vật
	var direction_to_target = target_position - player.global_position
	
	# Nếu độ lệch nhỏ hơn epsilon thì coi như đã đến vị trí đích và đúng yên (idle)
	if direction_to_target.length() < player.velocity.length() * delta:
		player.global_position = target_position
		direction_to_target = Vector2.ZERO
		player.velocity = Vector2.ZERO
		player.is_moving = false
		return
	
	# Chỉ cập nhật tốc độ khi chuyển khi có thay đổi địa chỉ đích
	if is_target_changed:
		# Tính toán độ dài đường di chuyển trong map bằng cách scale theo hệ số
		var scaled_direction = Vector2(direction_to_target.x / GameSettings.X_SCALE_FACTOR, direction_to_target.y / GameSettings.Y_SCALE_FACTOR)
			
		# Tính toán nhân tố scale tốc độ di chuyển dựa trên đường đi hiển thị và đường đi trong map
		var SPEED_SCALE_FACTOR = direction_to_target.length() / scaled_direction.length()
		
		# Chuẩn hóa đường đi thành hướng di chuyển và tính vận tốc
		direction_to_target = direction_to_target.normalized()
		player.velocity = direction_to_target * player.SPEED * SPEED_SCALE_FACTOR
		player.is_moving = true
		
		# Cập nhật hướng hoạt ảnh
		player.face_direction = direction_to_target
	
	player.move_and_slide()
