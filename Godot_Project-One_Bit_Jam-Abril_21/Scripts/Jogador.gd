extends KinematicBody2D

export(Vector2) var vel := Vector2(50,50)
export(float) var vel_coef = 0.8
export(Vector2) var vel_dash = Vector2(80, 80)
var vel_dash_temp := Vector2(20,20)
var dashing := false

func _ready():
	
	Global.connect("interacting_signal",self,"interaction_emmited")
	

func _physics_process(delta):
	
	mover_livre()
	animacao()

func interaction_emmited():
	if Global.wished_direction != Vector2.ZERO and !dashing:
		dashing = true
		$ColorRect.color = Color(0.8,0.5,0.5,1)
		yield(get_tree().create_timer(0.5), "timeout")
		dashing = false
		$ColorRect.color = Color(1,1,1,1)
		yield(get_tree().create_timer(0.2), "timeout")
		
	

func mover_livre():
	
	if not dashing:
		vel_dash_temp = Global.wished_direction * vel_dash
		
	
	move_and_slide(vel * Global.wished_direction * (1 - vel_coef * int(dashing) ) + vel_dash_temp * int(dashing),Vector2.ZERO)
	

func animacao():
	
	$AnimatedSprite.scale.x = Global.wished_direction.x if Global.wished_direction.x != 0 else $AnimatedSprite.scale.x
	$AnimatedSprite.playing = !dashing
	
	if dashing:
		$AnimatedSprite.frame = 1
		if !$AnimatedSprite/AnimationPlayer.is_playing():
			match $AnimatedSprite.scale.x:
				1.0:
					$AnimatedSprite/AnimationPlayer.play("Dash_dir")
				-1.0:
					$AnimatedSprite/AnimationPlayer.play("Dash_esq")
				
			
		
	
