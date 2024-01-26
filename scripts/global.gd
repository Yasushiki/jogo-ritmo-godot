extends Node2D


var pontos = 0
var combo = 0
var perfect = 0
var good = 0
var ok = 0
var missed = 0
var grade = "NA"


func set_pontos(new):
	pontos = new
	if pontos > 250000:
		grade = "A+"
	elif pontos > 200000:
		grade = "A"
	elif pontos > 150000:
		grade = "A-"
	elif pontos > 130000:
		grade = "B+"
	elif pontos > 115000:
		grade = "B"
	elif pontos > 100000:
		grade = "B-"
	elif pontos > 85000:
		grade = "C+"
	elif pontos > 70000:
		grade = "C"
	elif pontos > 55000:
		grade = "C-"
	elif pontos > 40000:
		grade = "D+"
	elif pontos > 30000:
		grade = "D"
	elif pontos > 20000:
		grade = "D-"
	else:
		grade = "F"
		
