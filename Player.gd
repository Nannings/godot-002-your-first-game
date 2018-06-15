extends Area2D

signal hit

export (int) var SPEED
var velocity = Vector2()
var screensize;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	hide()
	screensize = get_viewport_rect().size
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		$AnimatedSprite.play()
		$Trail.emitting = true
		velocity = velocity.normalized() * SPEED
	else:
		$AnimatedSprite.stop()
		$Trail.emitting = false
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x);
	position.y = clamp(position.y, 0, screensize.y);
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	

func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	call_deferred("set_monitoring", false)

func  start(pos):
	position = pos;
	monitoring = true
	show()
	
		
	
	
