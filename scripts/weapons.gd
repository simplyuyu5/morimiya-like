extends Node

@onready var parent = get_parent()

var damage = 0
var rounds_max = 0
var mags_max = 0
var shots = 1

var rounds = 0
var mags = 0


var primaries = {
	"ar15":{
		"sdamage":50,
		"srounds_max":30,
		"smags_max":4,
		"sshots":1
	},

	"m14":{
		"sdamage":90,
		"srounds_max":20,
		"smags_max":4,
		"sshots":1
	},

	"saiga":{
		"sdamage":80,
		"srounds_max":5,
		"smags_max":5,
		"sshots":1
	},
}





var current_sec = null
var current_prim = null

func weapon_change():
	if current_prim != null:
		#for i in primaries:
			#if primaries[current] == i:
				damage = primaries[current_prim]["sdamage"]
				rounds_max = primaries[current_prim]["srounds_max"]
				mags_max = primaries[current_prim]["smags_max"]
				shots = primaries[current_prim]["sshots"]

				mags = mags_max
				rounds = rounds_max

				print(mags_max," mags")
				print(damage," damage")
				print(rounds_max," rounds")
				#print(current_prim)
				#break
			#else:
				#print("cant find info")
	else:
		print("null")





#enum primary {
	#ar15,
	#m14,
	#saiga
#} 
#
#enum secondary{
	#m1911,
	#g18
#}
