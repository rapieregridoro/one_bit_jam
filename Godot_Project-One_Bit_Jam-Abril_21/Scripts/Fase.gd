extends Node2D

signal button_pressed_by_mouse

func _ready():
	
	#apagando rascunhos
	$Chao.queue_free()
	
	#atualizando o global
	
	connect("button_pressed_by_mouse",Global,"on_button_pressed_by_mouse")
	
	
	#para resetar as coisas por aqui
	Global.connect("reseta_tudo", self, "reseta_fase")
	

func _process(delta):
	
	pass



func set_camera_on_Jogador():
	Global.get_node("Camera_body").alvo = $YSort/Jogador.get_path()
	yield(get_tree().create_timer(0.5), "timeout")
	Global.get_node("Camera_body").vel_camera = 10

func reseta_fase():
	
	set_camera_on_Jogador()
	get_tree().change_scene("res://Scenes/Fase/Fase.tscn")
	
	pass

func _on_TextureButton_pressed():
	emit_signal("button_pressed_by_mouse")
	

