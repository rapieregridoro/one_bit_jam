extends Node



func _ready():
	Global.set_on_menu(true)
	get_tree().change_scene("res://Scenes/Fase/Fase.tscn")
	
	pass 

#func _process(delta):
#	pass
