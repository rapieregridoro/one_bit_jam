extends Node

#inputs
var wished_direction := Vector2.ZERO
var interacting := false
signal interacting_signal
signal aperte
signal botao_apertado

var on_menu = false

var vitoria := false
var vitoria_playied := false
signal reseta_tudo

func _ready():
	connect("reseta_tudo", self, "resetando_global")
	pass 

func _process(delta):
	
	wished_direction_inputs()
	
	if vitoria:
		vitoria()
	


func wished_direction_inputs():
	#pega os inputs do jogador
	wished_direction.x = (int(Input.is_action_pressed("ptb_right")) - int(Input.is_action_pressed("ptb_left")))
	wished_direction.y = (int(Input.is_action_pressed("ptb_down")) - int(Input.is_action_pressed("ptb_up")))
	interacting = Input.is_action_just_pressed("ui_select")
	if interacting:
		emit_signal("interacting_signal")
	

func vitoria():
	if !vitoria_playied:
		$Win_Altar/AnimationPlayer.play("Victory")
		vitoria_playied = true
	
	$Camera_body.vel_camera = 2
	$Camera_body.alvo = $Win_Camera_Pos.get_path()
	
	if !$Win_Altar/AnimationPlayer.is_playing():
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("reseta_tudo")
	

func resetando_global():
	vitoria = false
	vitoria_playied = false
	

func on_button_pressed_by_mouse():
	if on_menu:
		emit_signal("aperte")
	

func on_botao_apertado():
	vitoria = true
	pass
