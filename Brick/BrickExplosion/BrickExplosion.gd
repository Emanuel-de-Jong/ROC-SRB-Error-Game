extends Particles2D


func _ready():
	set_process(true)

func _process(delta):
	if !emitting:
		queue_free()