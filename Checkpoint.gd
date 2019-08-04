extends Node2D

func _ready():
	#$Portal.hide()
	pass

func _hit_by_player(area):
	#$Portal.show()
	#$Point.hide()
	$Area2D.queue_free()
	$AnimatedSprite.play()
