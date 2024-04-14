extends Node2D

# Propriedades configuráveis
@export var speed: float = 200.0  # Velocidade do míssil

var total_time: float = 1  # Tempo total para atingir o alvo
var target: Node2D  # O alvo a ser atingido
var damage: float

# Variáveis internas
var start_position: Vector2
var time_elapsed: float = 0.0
var initial_angle_offset: float = randf_range(-0.1, 0.1)  # Variação angular aleatória

func _ready():
	randomize()  # Garante que a função rand_range() gere valores aleatórios diferentes

func _process(delta):
	if not is_instance_valid(target):
		queue_free()
		return
		
	if not target:
		return
	
	
	time_elapsed += delta
	var t = time_elapsed / total_time  # Normaliza o tempo transcorrido
	if t > 1.0:
		t = 1.0
		target.damage(damage)
		queue_free()  # Destrói o míssil após atingir o alvo

	var last_position = global_position
	# Calcula a posição atual usando a interpolação
	var current_position = start_position.lerp(target.center.global_position, t)
	
	# Adiciona a curva do míssil
	var height_offset = sin(t * PI + initial_angle_offset) * 50.0  # 50 é o fator de escala da curva
	current_position.y -= height_offset

	# Atualiza a posição do míssil
	global_position = current_position

	# Atualiza a rotação para olhar em direção ao alvo
	rotation = last_position.angle_to_point(global_position)


func set_target(_target): 
	start_position = global_position
	self.target = _target
	
