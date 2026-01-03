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
	"xm15":{
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
		"sdesc":".223 Rem. Semi-automatic rifle with fine recoil and decent damage",
		"sbought":false,
		"cost":20000,
		"special":false
	},

	"m14":{
		"sreload_type":"mag",
		"sdamage":90,
		"srounds_max":20,
		"smags_max":4,
		"sdelay":0,
		"rel_time":3,
		"sshots":1,
		"sstyle":1,
		"srecoil":11,
		"sshell":0,
		"sdesc":"Reliable semi-automatic rifle with high damage and medium recoil",
		"sbought":true,
		"cost":0,
		"special":false
	},

	"saiga":{
		"sreload_type":"mag",
		"sdamage":80,
		"srounds_max":5,
		"smags_max":5,
		"sdelay":0.4,
		"rel_time":1.3,
		"sshots":1,
		"sstyle":1,
		"srecoil":18,
		"sshell":1,
		"sdesc":"Mag-fed shotgun, low capacity but faster reload",
		"sbought":false,
		"cost":10000,
		"special":false
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
		"sdesc":"Pump action shotgun to kill them slowly and with style",
		"sbought":false,
		"cost":7000,
		"special":false
	},

	"type95":{
		"sreload_type":"mag",
		"sdamage":45,
		"srounds_max":40,
		"smags_max":4,
		"sdelay":0,
		"rel_time":3,
		"sshots":1,
		"sstyle":1,
		"srecoil":4,
		"sshell":0,
		"sdesc":"5.8×42mm bullpup rifle",
		"sbought":false,
		"cost":15000,
		"special":false
	},

		"anzio":{
		"sreload_type":"mag",
		"sdamage":1000,
		"srounds_max":3,
		"smags_max":10,
		"sdelay":1,
		"rel_time":2,
		"sshots":1,
		"sstyle":2,
		"srecoil":50,
		"sshell":0,
		"sdesc":"20×102 mm anti-materiel rifle, 2 m long \n weights more than 20 kg",
		"sbought":false,
		"cost":"we are not selling that :p",
		"special":true
	},


	"ak12":{
		"sreload_type":"mag",
		"sdamage":50,
		"srounds_max":40,
		"smags_max":4,
		"sdelay":0,
		"rel_time":2,
		"sshots":1,
		"sstyle":1,
		"srecoil":5,
		"sshell":0,
		"sdesc":"5.45x39 rifle with good damage and magazine capacity",
		"sbought":false,
		"cost":15000,
		"special":false
	},
}

var secondaries = {
	"g17":{
		"sreload_type":"mag",
		"sdamage":30,
		"srounds_max":17,
		"smags_max":4,
		"sdelay":0,
		"rel_time":1,
		"sshots":1,
		"sstyle":0,
		"srecoil":2,
		"sshell":2,
		"sdesc":"Popular handgun that takes a lot shots to kill someone \n while having a magazine big enough to do so",
		"sbought":true,
		"cost":0,
		"special":false
	},

	"tt":{
		"sreload_type":"mag",
		"sdamage":55,
		"srounds_max":8,
		"smags_max":2,
		"sdelay":0,
		"rel_time":2,
		"sshots":1,
		"sstyle":0,
		"srecoil":2,
		"sshell":2,
		"sdesc":"description placeholder",
		"sbought":false,
		"cost":10,
		"special":false
	}
}

#ADD GRENADES !!!!!!!!!

var current_sec = "g17"
var current_prim = "m14"
var current_melee = "null"
var current_gren = "null"
var in_hands = "m14"

func _ready() -> void:
	weapon_change(1)

func weapon_change(num):
	if in_hands != null:
		match num:
			1:
				if primaries[in_hands] != null:
					#current_prim = in_hands
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

			2:
				if secondaries[in_hands] != null:
					#current_sec = in_hands
					damage = secondaries[in_hands]["sdamage"]
					rounds_max = secondaries[in_hands]["srounds_max"]
					mags_max = secondaries[in_hands]["smags_max"]
					shots = secondaries[in_hands]["sshots"]
					style = secondaries[in_hands]["sstyle"]
					recoil = secondaries[in_hands]["srecoil"]
					shell = secondaries[in_hands]["sshell"]
					description = secondaries[in_hands]["sdesc"]
					reload_type = secondaries[in_hands]["sreload_type"]
					reload_time = secondaries[in_hands]["rel_time"]
					delay = secondaries[in_hands]["sdelay"]
					mags = mags_max
					rounds = rounds_max

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
