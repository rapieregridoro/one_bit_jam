extends KinematicBody2D

export(NodePath) var alvo
export(float) var vel_camera


func _ready():
	alvo = self.get_path()
	pass

func _process(delta):
	if alvo != null:
		move_and_slide((get_node(alvo).global_position - global_position) * vel_camera, Vector2.ZERO)
	pass
