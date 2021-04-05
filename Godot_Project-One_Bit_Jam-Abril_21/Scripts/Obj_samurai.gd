extends Node2D



func _ready():
	pass # Replace with function body.

#func _process(delta):
#	pass

func Corte():
	Global.emit_signal("corte_samurai")
	
