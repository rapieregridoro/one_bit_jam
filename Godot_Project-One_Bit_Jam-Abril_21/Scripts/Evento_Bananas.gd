extends YSort

var pre_banana : PackedScene = load("res://Scenes/Objetos/Obj_bananas.tscn")
var banana


func _ready():
	randomize()
	for a in randi()%5 + 10:
		banana = pre_banana.instance()
		banana.position.x = randi()%90 - 45
		banana.position.y = randi()%75 - 35
		add_child(banana)
		
	 


func _process(delta):
	pass
