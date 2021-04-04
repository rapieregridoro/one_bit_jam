extends Node2D

export(Array, PackedScene) var Eventos
var event_number

func _ready():
	randomize()
	Pick_Event()

func _process(delta):
	
	pass

func Pick_Event():
	var random_number
	random_number = randi() % Eventos.size()
	event_number = random_number

func Spawn_Event():
	
	var evento = Eventos[event_number].instance()
	add_child(evento)
	
	


func _on_Area2D_body_entered(body):
	Spawn_Event()
	