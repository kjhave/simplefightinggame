class_name Player
extends CharacterBody2D

#stat
var SPEED = 150.0
var ATTACK_SPEED = 1.0

#state
var is_moving = false
var is_attacking = false
var face_direction = Vector2.ZERO

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass

func cmt():
	if Input.is_action_just_pressed("cast_attack") && !is_attacking:
		velocity = Vector2.ZERO
		is_moving = false
		is_attacking = true
		return
