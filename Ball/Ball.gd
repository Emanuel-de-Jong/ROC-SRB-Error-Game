extends RigidBody2D

export var yPos = 480
export var startingSpeed = 200
var freeze = false
var ballScene = load("res://Ball/Ball.tscn")
var brickExplosionScene = preload("res://Brick/BrickExplosion/BrickExplosion.tscn")
onready var lifes = get_tree().get_root().get_node("Main/Lifes")
onready var bricks = get_tree().get_root().get_node("Main/Bricks")
var speed = startingSpeed
var highestBrickRowTouched = BrickRowNames.None
var velocity = 0

enum BrickRowNames{
  None, Red, Green, Blue
}

func _ready():
	set_physics_process(true)
	
	name = "Ball"
	
	var mouseX = get_viewport().get_mouse_position().x
	position = Vector2(mouseX, yPos)
	
	randomize()
	var randomNumber = randi()%2
	if randomNumber == 0:
		linear_velocity = Vector2(startingSpeed, -startingSpeed)
	elif randomNumber == 1:
		linear_velocity = Vector2(-startingSpeed, -startingSpeed)

func _physics_process(delta):
	if freeze:
		linear_velocity = Vector2(0, 0)
	else:
	    velocity = get_linear_velocity().normalized()*speed
	    linear_velocity = velocity

func _on_Ball_body_entered(body):
	if body.is_in_group("Bricks"):
		var brickExplosion = brickExplosionScene.instance()
		brickExplosion.position = body.position
		brickExplosion.emitting = true
		get_tree().get_root().get_node("Main").add_child(brickExplosion)
		
		body.queue_free()
		
		if bricks.check_if_won():
			queue_free()
		
		if body.is_in_group("Red") && highestBrickRowTouched != BrickRowNames.Red:
			highestBrickRowTouched = BrickRowNames.Red
			speed = startingSpeed + 400
		elif body.is_in_group("Green") && highestBrickRowTouched != BrickRowNames.Red && highestBrickRowTouched != BrickRowNames.Green:
			highestBrickRowTouched = BrickRowNames.Green
			speed = startingSpeed + 250
		elif body.is_in_group("Blue") && highestBrickRowTouched == BrickRowNames.None:
			highestBrickRowTouched = BrickRowNames.Blue
			speed = startingSpeed + 100
			
	elif body.name == "Paddle":
		var direction = position - body.position
		var newVelocity = direction.normalized()*speed
		linear_velocity = newVelocity
		
	elif body.name == "Ground":
		if lifes.hide_life():
			var ball = ballScene.instance()
			get_tree().get_root().get_node("Main").add_child(ball)
			
			queue_free()