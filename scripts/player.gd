extends CharacterBody2D

@onready var camera = $Camera2D

var ennemy_in_attack_range = false
var ennemy_attack_cooldown = true
var health = 100
var player_alive = true
var attack_ip = false
var player_name = "Player"

const speed = 100
var current_dir = "down"

func _ready():
	$player_name_label.text = Global.player_name
	$AnimatedSprite2D.play("front_idle")
	camera.make_current()

func _physics_process(delta: float) -> void:
	player_movement(delta)
	ennemy_attack()
	attack()
	update_health()
	
	if health <= 0:
		player_alive = false
		$AnimatedSprite2D.play("death")
		health = 0
	
func player_movement(delta):
	if player_alive == false:
		return

	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()


func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("side_idle")
	if dir == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("back_idle")
	if dir == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			if attack_ip == false:
				anim.play("front_idle")

func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("ennemy"):
		ennemy_in_attack_range = true


func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("ennemy"):
		ennemy_in_attack_range = false
		
		
func ennemy_attack():
	if ennemy_in_attack_range and ennemy_attack_cooldown == true:
		health -= 10
		ennemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout() -> void:
	ennemy_attack_cooldown = true

func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
		elif dir == "up":
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()
		elif dir == "down":
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()


func _on_deal_attack_timer_timeout() -> void:
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = false

func current_camera():
	if Global.current_scene == "world":
		$world_camera.make_current()
	elif Global.current_scene == "cliff_side":
		$cliffside_camera.make_current()


func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regen_timer_timeout() -> void:
	if health < 100:
		health += 20
		if health > 100:
			health = 100
	elif health == 0:
		health = 0


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "death":
		self.hide()
		set_process(false)
		var game_over_scene = load("res://scenes/game_over.tscn")
		var game_over = game_over_scene.instantiate()
		get_tree().current_scene.add_child(game_over)
