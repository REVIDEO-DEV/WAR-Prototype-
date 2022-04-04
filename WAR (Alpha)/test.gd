extends Node2D

onready var Water = $Water
onready var Ground = $Ground
export var width := 210
export var height := 90
export var in_seed := ""
var osn := OpenSimplexNoise.new()



func _ready() -> void:
	randomize()
	if in_seed:
		osn.seed = hash(in_seed)
		print(hash(in_seed))
	else:
		osn.seed = randi()
	generate_map()

func generate_map() -> void:
	for x in width:
		for y in height:
			var rand := floor((abs(osn.get_noise_2d(x,y)))*7)
			Ground.set_cell(x,y, rand)
	pass


func _on_period_slider_value_changed(value: float) -> void:
	osn.period = value
	generate_map()


func _on_octave_slider_value_changed(value: float) -> void:
	osn.octaves = value
	generate_map()
