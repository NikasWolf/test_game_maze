# На Area2D или StaticBody2D
extends StaticBody2D

func _ready():
	# Добавляем в группу убийственных объектов
	add_to_group("kill_zone")
	
	# Если используете Area2D - подключаем сигнал
	if self is StaticBody2D:
		connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if body.is_in_group("player"):  # если игрок в группе "player"
		body.die()
