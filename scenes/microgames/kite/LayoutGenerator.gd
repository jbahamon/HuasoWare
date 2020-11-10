
var difficulty

var TreeEnemy = preload("res://scenes/microgames/kite/Enemies/TreeEnemy.tscn")
var Cloud = preload("res://scenes/microgames/kite/Enemies/Cloud.tscn")
var Birb = preload("res://scenes/microgames/kite/Enemies/Birb.tscn")
var TueTue = preload("res://scenes/microgames/kite/Enemies/TueTue.tscn")

var birb_squad_low = {
	"type": Birb,
	"elements": [
		{"position": Vector2(0, 360), "frame": 0, "phase": PI},	
		{"position": Vector2(80, 360), "frame": 2, "phase": 3*PI/4.0},
		{"position": Vector2(160, 360), "frame": 1, "phase": PI/2.0},
		{"position": Vector2(240, 360), "frame": 0, "phase": PI/4.0},	
		{"position": Vector2(320, 360), "frame": 3},
	],
	"movement": {
		"frequency": 0.5, 
		"amplitude": 420, 
		"phase": 0
	}
}

var birb_squad_high = {
	"type": Birb,
	"elements": [
		{"position": Vector2(0, 120), "frame": 0, "phase": PI},	
		{"position": Vector2(80, 120), "frame": 2, "phase": 3*PI/4.0},
		{"position": Vector2(160, 120), "frame": 1, "phase": PI/2.0},
		{"position": Vector2(240, 120), "frame": 0, "phase": PI/4.0},	
		{"position": Vector2(320, 120), "frame": 3},
	],
	"movement": {
		"frequency": 0.5, 
		"amplitude": 420, 
		"phase": 0
	},
}

var birb_squad_wide = {
	"type": Birb,
	"elements": [
		{"position": Vector2(0, 240), "frame": 0, "phase": PI},	
		{"position": Vector2(80, 240), "frame": 1, "phase": 3*PI/4.0},	
		{"position": Vector2(160, 240), "frame": 2, "phase": PI/2.0},
		{"position": Vector2(240, 240), "frame": 3, "phase": PI/4.0},
		{"position": Vector2(320, 240), "frame": 0},
	],
	"movement": {
		"frequency": 0.75, 
		"amplitude": 420,
	}
}

var clouds = {
	"type": Cloud,
	"elements": [
		{"position": Vector2(0, 100), "frame": 0},	
		{"position": Vector2(70, 120), "frame": 2},
		{"position": Vector2(147, 110), "frame": 1},
		{"position": Vector2(228, 98), "frame": 0},	
		{"position": Vector2(331, 123), "frame": 3},
		{"position": Vector2(400, 105), "frame": 0}
	]
}

var trees = {
	"type": TreeEnemy,
	"elements": [
		{"position": Vector2(0, 500), "frame": 0},	
		{"position": Vector2(80, 520), "frame": 2},
		{"position": Vector2(160, 480), "frame": 1},
		{"position": Vector2(240, 560), "frame": 0},	
		{"position": Vector2(320, 540), "frame": 3},
		{"position": Vector2(400, 510), "frame": 0}
	]
}

var tuetue_squad = {
	"type": TueTue,
	"elements": [
		{"point1": Vector2(-60, 120), "point2": Vector2(-180, 120), "positioning_time": 0.5},
		{"point1": Vector2(0, 240), "point2": Vector2(-180, 240), "positioning_time": 1},
		{"point1": Vector2(60, 360), "point2": Vector2(-180, 360), "positioning_time": 1.5},
	],
}

var high = [birb_squad_high, clouds]
var wide = [tuetue_squad, birb_squad_wide]
var low = [birb_squad_low, trees]

func _init(game_difficulty):
	self.difficulty = game_difficulty
	
func get_layout():
	randomize()
	var layout = [
		high[randi() % high.size()].duplicate(), 
		wide[randi() % wide.size()].duplicate(), 
		low[randi() % low.size()].duplicate(), 
	]
	layout.shuffle()
	var timestamp = 0.1
	
	for element in layout:
		element.timestamp = timestamp
		timestamp += 1.8
		
	return layout
	
	
