extends Node2D



func _ready():
	$Chao.queue_free()
	Global.get_node("Camera_body").alvo = $Jogador.get_path()
	

func _process(delta):
	
	pass
