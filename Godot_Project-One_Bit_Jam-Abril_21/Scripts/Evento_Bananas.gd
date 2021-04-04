extends Node2D

var pre_banana : PackedScene = load("res://Scenes/Objetos/Obj_bananas.tscn")
var banana = pre_banana.instance()

func _ready():
	add_child(banana)
	pass 


func _process(delta):
	pass
