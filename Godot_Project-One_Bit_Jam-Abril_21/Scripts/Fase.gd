extends Node2D

signal button_pressed_by_mouse

func _ready():
	
	#apagando rascunhos
	$Chao.queue_free()
	
	#atualizando o global
	Global.get_node("Camera_body").alvo = $YSort/Jogador.get_path()
	connect("button_pressed_by_mouse",Global,"on_button_pressed_by_mouse")
	

func _process(delta):
	
	pass


func _on_TextureButton_pressed():
	emit_signal("button_pressed_by_mouse")
	
