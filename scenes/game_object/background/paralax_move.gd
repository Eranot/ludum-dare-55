extends ParallaxLayer

@export var speed: Vector2

func _process(delta):
	self.motion_offset += speed * delta
