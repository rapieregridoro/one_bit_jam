extends YSort

export(Array, PackedScene) var Eventos
var event_number
var spawned = false

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
	
	if !spawned:
		var evento = Eventos[event_number].instance()
		add_child(evento)
		spawned = true
	
	


func _on_Area2D_body_entered(body):
	Spawn_Event()
	
