extends StaticBody2D



func _ready():
	
	pass 


func _process(delta):
	
	pass


func _on_Area2D_body_entered(body):
	Global.emit_signal("morreu","fogo")
	
