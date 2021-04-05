extends KinematicBody2D

export(Vector2) var vel := Vector2(50,50)
export(float) var vel_coef = 0.8
export(Vector2) var vel_dash = Vector2(80, 80)
var vel_dash_temp := Vector2(20,20)
var dashing := false
var dash_collinding := false
var how_many_dash_col = 0
export(bool) var tombando = false
export(float) var coef_tombando
var timer_dash : float = 0
export(float) var delay_dash = 0.5

var morto := false
var omae_wa_mou := false

func _ready():
	Global.connect("morreu", self, "Morte")
	Global.connect("interacting_signal",self,"interaction_emmited")
	Global.connect("corte_samurai",self,"check_dash")
	set_collision_layer_bit(6, true)
	

func _physics_process(delta):
	timer_dash += delta
	
	$ProgressBar.visible = timer_dash < delay_dash
	$ProgressBar.value = timer_dash/delay_dash
	
	if !Global.on_menu:
		mover_livre()
		animacao()
	
	$Collision_Dash.rotation = vel_dash_temp.angle()
	
	

func check_dash():
	
	if !dashing:
		omae_wa_mou = true
		yield(get_tree().create_timer(0.5), "timeout")
		Global.emit_signal("morreu","shindeiru")
	


func interaction_emmited():
	#chamado quando sinal de interação é emitido
	if Global.wished_direction != Vector2.ZERO and !dashing and !tombando and timer_dash > delay_dash:
		dashing = true
		yield(get_tree().create_timer(0.5), "timeout")
		timer_dash = 0
		dashing = false
		yield(get_tree().create_timer(0.2), "timeout")
		
	

func mover_livre():
	
	if not dashing:
		vel_dash_temp = Global.wished_direction.normalized() * vel_dash
		
	
	if dashing and dash_collinding:
		tombou()
		
	
	if !morto:
		move_and_slide(vel * Global.wished_direction.normalized() * (1 - vel_coef * int(dashing) ) + vel_dash_temp * int(dashing) * (1 - coef_tombando * int(tombando) ),Vector2.ZERO)
	

func tombou():
	$AnimationPlayer.play("tombando")
	

func Morte(como):
	morto = true
	match como:
		"banana":
			$AnimationPlayer.play("escorregando")
			
		"fogo":
			$AnimationPlayer.play("tostando")
			
		"shindeiru":
			
			yield(get_tree().create_timer(1.0), "timeout")
			
		
	yield(get_tree().create_timer(1.0), "timeout")
	Global.emit_signal("reseta_tudo")

func animacao():
	
	if !morto:
		$AnimatedSprite.scale.x = Global.wished_direction.x if Global.wished_direction.x != 0 else $AnimatedSprite.scale.x
		if Global.wished_direction == Vector2.ZERO:
			$AnimatedSprite.animation = "idle"
		else:
			$AnimatedSprite.animation = "walk"
		
		if dashing:
			$AnimatedSprite.animation = "dash"
			if !$AnimatedSprite/AnimationPlayer.is_playing():
				match $AnimatedSprite.scale.x:
					1.0:
						$AnimatedSprite/AnimationPlayer.play("Dash_dir")
					-1.0:
						$AnimatedSprite/AnimationPlayer.play("Dash_esq")
					
				
			
		if tombando:
			$AnimatedSprite.animation = "knock_back"
			$AnimatedSprite/AnimationPlayer.stop()
			$AnimatedSprite.rotation = 0
		
	
	


func _on_Collision_Dash_body_entered(body):
	how_many_dash_col += 1
	dash_collinding = true
	


func _on_Collision_Dash_body_exited(body):
	
	how_many_dash_col -= 1
	
	if how_many_dash_col <= 0:
		dash_collinding = false
		how_many_dash_col = 0
	
