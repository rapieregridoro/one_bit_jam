extends KinematicBody2D

export(NodePath) var alvo
export(float) var vel_camera

func _ready():
	
	pass


func _process(delta):
	move_and_slide((get_node(alvo).global_position - global_position) * vel_camera, Vector2.ZERO)
	pass
