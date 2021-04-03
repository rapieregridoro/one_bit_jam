extends Node

#inputs
var wished_direction := Vector2.ZERO
var interacting := false
signal interacting_signal

func _ready():
	
	pass 

func _process(delta):
	
	wished_direction_inputs()
	
	


func wished_direction_inputs():
	#pega os inputs do jogador
	wished_direction.x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	wished_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	interacting = Input.is_action_just_pressed("ui_select")
	if interacting:
		emit_signal("interacting_signal")
	
