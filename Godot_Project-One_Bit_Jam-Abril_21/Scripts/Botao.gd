extends Node2D

func _ready():
	Global.connect("aperte", self, "on_aperte")
	pass 

func _process(delta):
	
	pass

func anim_press():
	$Sprite/AnimationPlayer.play("apertar")
	

func on_aperte():
	anim_press()
	
