extends KinematicBody2D

var vel := Vector2(50,50)


func _ready():
	
	pass 

func _physics_process(delta):
	
	
	mover_livre()
	


func mover_livre():
	
	move_and_slide(vel * Global.wished_direction,Vector2.ZERO)
	
	pass
