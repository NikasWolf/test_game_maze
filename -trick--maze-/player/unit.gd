extends CharacterBody2D

const SPEED = 10000.0
var is_alive = true

func _physics_process(delta: float):
	if not is_alive:
		return
	
	var direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	)

	velocity = direction * SPEED * delta
	move_and_slide()
	
	# Проверяем столкновения после движения
	check_collisions()

func check_collisions():
	# Проверяем все столкновения за этот кадр
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Если столкнулись с объектом в группе "kill_zone" - умираем
		if collider != null and collider.is_in_group("kill_zone"):
			die()
		if collider != null and collider.is_in_group("exit"):
			wins()
func die():
	if not is_alive:
		return
	
	is_alive = false
	print("Игрок умер!")
	
	# Отключаем коллайдер игрока
	$CollisionShape2D.set_deferred("disabled", true)
	
	# Можно добавить анимацию смерти
	get_tree().change_scene_to_file("res://game/ded_window.tscn")
	
func wins():
	get_tree().change_scene_to_file("res://game/win_window.tscn")
