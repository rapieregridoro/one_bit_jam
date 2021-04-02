extends Node

#inputs
var wished_direction := Vector2.ZERO

func _ready():
	
	pass 

func _process(delta):
	
	wished_direction_inputs()
	
	


func wished_direction_inputs():
	#pega os inputs do jogador
	wished_direction.x = (int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")))
	wished_direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	
