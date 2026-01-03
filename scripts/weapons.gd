extends Node

@onready var parent = get_parent()

var reload_type = "mag" 
var shots = 1 #for burst fire?
var damage = 0
var recoil = 0
var description :String = ""
var reload_time = 1 #time needed to reload in s 
var delay = 0 #delay between shots #P.S. morimiya's BS3, KS25 and many other shotguns are reason for adding this

var style = 0 
var shell = 0

var chance_hit :int = 100
var chance_max = 100

var max_angle = 20
var angle = 0
var min_angle = -20

var rounds_max = 0
var mags_max = 0
var rounds = 0
var mags = 0



var primaries = {
	"ar15":{
		"sreload_type":"mag",
		"sdamage":50,
		"srounds_max":30,
		"smags_max":4,
		"sdelay":0,
		"rel_time":1.5,
		"sshots":1,
		"sstyle":0,
		"srecoil":6,
		"sshell":0,
		"sdesc":"Semi-automatic rifle with fine recoil and decent damage.",
		"sbought":false
	},

	"m14":{
		"sreload_type":"mag",
		"sdamage":90,
		"srounds_max":20,
		"smags_max":4,
		"sdelay":0,
		"rel_time":4,
		"sshots":1,
		"sstyle":1,
		"srecoil":11,
		"sshell":0,
		"sdesc":"Reliable semi-automatic rifle with high damage and medium recoil",
		"sbought":true
	},

	"saiga":{
		"sreload_type":"mag",
		"sdamage":80,
		"srounds_max":5,
		"smags_max":5,
		"sdelay":0.4,
		"rel_time":2,
		"sshots":1,
		"sstyle":1,
		"srecoil":18,
		"sshell":1,
		"sdesc":"Magazine fed shotgun, low capacity but faster to reload",
		"sbought":false
	},

	"m500":{
		"sreload_type":"pump",
		"sdamage":110,
		"srounds_max":8,
		"smags_max":24,
		"sdelay":0.7,
		"rel_time":1,
		"sshots":1,
		"sstyle":1,
		"srecoil":22,
		"sshell":1,
		"sdesc":"description placeholder",
		"sbought":false
	},

	"type81":{
		"sreload_type":"mag",
		"sdamage":45,
		"srounds_max":40,
		"smags_max":3,
		"sdelay":0,
		"rel_time":3,
		"sshots":1,
		"sstyle":1,
		"srecoil":5,
		"sshell":0,
		"sdesc":"description placeholder",
		"sbought":false
	},
}

var secondaries = {
	"g17":{
		"sreload_type":"mag",
		"sdamage":10,
		"srounds_max":17,
		"smags_max":2,
		"sdelay":0,
		"rel_time":1,
		"sshots":1,
		"sstyle":0,
		"srecoil":2,
		"sshell":2,
		"sdesc":"description placeholder",
		"sbought":true,
		"cost":10
	},

	"tt":{
		"sreload_type":"mag",
		"sdamage":25,
		"srounds_max":8,
		"smags_max":2,
		"sdelay":0,
		"rel_time":2,
		"sshots":1,
		"sstyle":0,
		"srecoil":2,
		"sshell":2,
		"sdesc":"description placeholder",
		"sbought":false
	}
}

#ADD GRENADES !!!!!!!!!

var current_sec = "null"
var current_prim = "null"
var current_melee = "null"
var in_hands = "null"

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
				recoil = primaries[in_hands]["srecoil"]
				shell = primaries[in_hands]["sshell"]
				description = primaries[in_hands]["sdesc"]
				reload_type = primaries[in_hands]["sreload_type"]
				reload_time = primaries[in_hands]["rel_time"]
				delay = primaries[in_hands]["sdelay"]

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
				recoil = secondaries[in_hands]["srecoil"]
				shell = secondaries[in_hands]["sshell"]
				description = secondaries[in_hands]["sdesc"]

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
		in_hands = "null"


func recoil_regen():
	if parent.spread == false:
		chance_hit += 1
	else:
		pass


func _process(_delta: float) -> void:

	recoil_regen()

	if chance_hit <= 0:
		chance_hit = 0
	if chance_hit >= chance_max:
		chance_hit = chance_max


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
