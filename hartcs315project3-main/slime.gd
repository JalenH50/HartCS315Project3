extends CharacterBody2D

signal damage_player(amount)

@export var damage:float = 1
@export var speed:float = 10
@export var sprite:Sprite2D
@export var target:CharacterBody2D
@export var move_timer : Timer
@export var animation_player: AnimationPlayer
@export var damage_timer : Timer

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


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("damage_player", damage)
		damage_timer.start()
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	damage_timer.stop()


func _on_damage_timer_timeout() -> void:
	print("player damaged")
	emit_signal("damage_player", damage)
