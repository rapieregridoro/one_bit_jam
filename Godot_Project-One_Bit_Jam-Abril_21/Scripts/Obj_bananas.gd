extends RigidBody2D

var delay
var ja_caiu = false

func _ready():
	randomize()
	delay = randf()/2
	


func _process(delta):
	if !ja_caiu:
		yield(get_tree().create_timer(delay), "timeout")
		$AnimationPlayer.play("Cai_a_banana")
		ja_caiu = true
	
