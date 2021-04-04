extends Node2D

func _ready():
	Global.connect("aperte", self, "on_aperte")
	Global.connect("botao_apertado", Global, "on_botao_apertado")
	pass 

func _process(delta):
	if Global.on_menu and Input.is_action_just_pressed("Dash"):
		Global.on_button_pressed_by_mouse()
		pass
	pass

func anim_press():
	$Sprite/AnimationPlayer.play("apertar")
	

func on_aperte():
	anim_press()
	

func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	anim_press()
	Global.emit_signal("botao_apertado")
	
