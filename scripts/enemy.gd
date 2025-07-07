extends CharacterBody2D

var speed = 40
var player_chase = false
var player = null

var health = 100
var player_in_attack_range = false
var can_take_damage = true
var is_dead = false

func _ready():
	if Global.ennemies_killed.has("slime_world"):
		is_dead = true
		self.queue_free()

func _physics_process(delta: float) -> void:
	if is_dead: return
	deal_with_damage()
	if player_chase:
		if is_dead:
			$AnimatedSprite2D.play("death")
		else:
			position += (player.position - position)/speed
			$AnimatedSprite2D.play("walk")
			if(player.position.x - position.x) <0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()
	update_health()

func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func ennemy():
	pass


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_attack_range = false

func deal_with_damage():
	if is_dead: return
	if player_in_attack_range and Global.player_current_attack == true:
		if can_take_damage == true:
			health -= 20
			$take_damage_cooldown.start()
			can_take_damage = false
			if health == 0:
				Global.ennemies_killed["slime_world"] = true
				is_dead = true


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true

func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		queue_free()
