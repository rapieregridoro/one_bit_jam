extends StaticBody2D



func _ready():
	
	pass 


func _process(delta):
	$ColorRect.color.a = int(!$Particles2D/Area2D/CollisionPolygon2D.disabled)
	pass


func _on_Area2D_body_entered(body):
	Global.emit_signal("morreu","fogo")
	
