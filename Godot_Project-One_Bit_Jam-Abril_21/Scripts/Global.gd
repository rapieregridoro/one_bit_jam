extends Node

#inputs
var wished_direction := Vector2.ZERO
var interacting := false
signal interacting_signal
signal aperte
signal botao_apertado

var on_menu = true setget set_on_menu
func set_on_menu(menu):
	on_menu = menu
	if on_menu:
		$Camera_body.alvo = $Menu_Pos.get_path()
	
	

var vitoria := false
var vitoria_playied := false
signal reseta_tudo

signal morreu(como)

func _ready():
	connect("reseta_tudo", self, "resetando_global")
	

func _process(delta):
	
	wished_direction_inputs()
	
	if vitoria:
		vitoria()
	
	


func wished_direction_inputs():
	#pega os inputs do jogador
	wished_direction.x = (int(Input.is_action_pressed("ptb_right")) - int(Input.is_action_pressed("ptb_left")))
	wished_direction.y = (int(Input.is_action_pressed("ptb_down")) - int(Input.is_action_pressed("ptb_up")))
	interacting = Input.is_action_just_pressed("Dash")
	if interacting:
		emit_signal("interacting_signal")
	

func vitoria():
	if !vitoria_playied:
		$Win_Altar/AnimationPlayer.play("Victory")
		vitoria_playied = true
	$Limite_Cam/StaticBody2D.set_collision_layer_bit(0, false)
	$Camera_body.vel_camera = 2
	$Camera_body.alvo = $Win_Camera_Pos.get_path()
	
	if !$Win_Altar/AnimationPlayer.is_playing():
		yield(get_tree().create_timer(1.5), "timeout")
		emit_signal("reseta_tudo")
	

func resetando_global():
	vitoria = false
	vitoria_playied = false
	$Win_Altar/Sprite.frame = 0
	$Limite_Cam/StaticBody2D.set_collision_layer_bit(0,true)
	

func on_button_pressed_by_mouse():
	if on_menu:
		emit_signal("aperte")
		yield(get_tree().create_timer(1.0), "timeout")
		$Menu.hide()
		$Camera_body/Camera2D/AnimationCamera.play("Zoom_in")
		emit_signal("reseta_tudo")
		on_menu = false
	

func on_botao_apertado():
	vitoria = true
	pass
