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

var morto := false


func _ready():
	Global.connect("morreu", self, "Morte")
	Global.connect("interacting_signal",self,"interaction_emmited")
	

func _physics_process(delta):
	
	mover_livre()
	animacao()
	
	$Collision_Dash.rotation = vel_dash_temp.angle()
	
	


func interaction_emmited():
	#chamado quando sinal de interação é emitido
	if Global.wished_direction != Vector2.ZERO and !dashing and !tombando:
		dashing = true
		yield(get_tree().create_timer(0.5), "timeout")
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
	match como:
		"banana":
			print("morreu pra banana")
			pass
		
	

func animacao():
	
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
	
