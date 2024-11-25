extends CharacterBody2D

@export var speed:float = 10
@export var sprite:Sprite2D
@export var target = CharacterBody2D
@export var move_timer : Timer
@export var animation_player: AnimationPlayer

func _ready():
	target = get_node("../Player")
	move_timer.start(2)

func _on_move_timer_timeout() -> void:
	var direction = position.direction_to(target.position)
	velocity = direction * speed
	move_and_collide(velocity)

	if direction.x < 0:
		animation_player.play("move")
		sprite.scale.x = 1
	elif direction.x > 0:
		animation_player.play("move")
		sprite.scale.x = -1
	
	move_timer.start(2)
