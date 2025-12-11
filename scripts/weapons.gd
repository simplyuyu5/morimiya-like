extends Node

@onready var parent = get_parent()

var reload_type = "mag"
var damage = 0
var rounds_max = 0
var mags_max = 0
var shots = 1
var style = 0

var rounds = 0
var mags = 0


var primaries = {
	"ar15":{
		"sreload_type":"mag",
		"sdamage":50,
		"srounds_max":30,
		"smags_max":4,
		"sshots":1,
		"sstyle":0
	},

	"m14":{
		"sreload_type":"mag",
		"sdamage":90,
		"srounds_max":20,
		"smags_max":4,
		"sshots":1,
		"sstyle":1
	},

	"saiga":{
		"sreload_type":"mag",
		"sdamage":80,
		"srounds_max":5,
		"smags_max":5,
		"sshots":1,
		"sstyle":1
	},

	"m500":{
		"sreload_type":"pump",
		"sdamage":110,
		"srounds_max":8,
		"smags_max":24,
		"sshots":1,
		"sstyle":1
	},

	"type81":{
		"sreload_type":"mag",
		"sdamage":45,
		"srounds_max":40,
		"smags_max":3,
		"sshots":1,
		"sstyle":1
	},
}

var secondaries = {
	"g17":{
		"sreload_type":"mag",
		"sdamage":10,
		"srounds_max":17,
		"smags_max":2,
		"sshots":1,
		"sstyle":0
	},

	"tt":{
		"sreload_type":"mag",
		"sdamage":25,
		"srounds_max":8,
		"smags_max":2,
		"sshots":1,
		"sstyle":0
	}
}



var current_sec = null
var current_prim = null
var in_hands = null

func weapon_change():
	if in_hands != null:
		#for i in primaries:
			#if primaries[current] == i:
			if primaries[in_hands] != null:
				current_prim = in_hands
				damage = primaries[in_hands]["sdamage"]
				rounds_max = primaries[in_hands]["srounds_max"]
				mags_max = primaries[in_hands]["smags_max"]
				shots = primaries[in_hands]["sshots"]
				style = primaries[in_hands]["sstyle"]

				mags = mags_max
				rounds = rounds_max

				print(mags_max," mags")
				print(damage," damage")
				print(rounds_max," rounds")

			elif secondaries[in_hands] != null:
				current_sec = in_hands
				damage = secondaries[in_hands]["sdamage"]
				rounds_max = secondaries[in_hands]["srounds_max"]
				mags_max = secondaries[in_hands]["smags_max"]
				shots = secondaries[in_hands]["sshots"]
				style = secondaries[in_hands]["sstyle"]

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
