extends Node

var currentJerboa : JerboaPlayer = null

var Spells = {}

var unlockedSpells = []

var playedRooms = []

var SpellSource = [
	{"name":"Super Jump",
	"desc":"[A,B,A] Propels you high into the air!",
	"code" : [0,1,0],
	"texture": preload("res://art/upgrade/bigboost.png"),
	 "scene":  preload("res://scenes/spells/superjump.tscn")},
	{"name":"Stairway Creation",
	"texture":preload("res://art/upgrade/stair.png"),
	"desc":"[B,A,A] Creates a stairway infront of you",
	"code" : [1,0,0],
	"scene" : preload("res://scenes/spells/stairwaycreation.tscn")
	},
	{"name":"Grappling Hook",
	"texture":preload("res://art/upgrade/grappling.png"),
	"desc":"[B,A,A,B,A] Brings you UP!",
	"code" : [1,0,0,1,0],
	"scene" : preload("res://scenes/spells/grapplingHook.tscn")
	}
	
]

var rooms = [
	{"neededSpells":[[0,1,0]],"path":"res://scenes/rooms/bigJumpRoomOne.tscn"},
	{"neededSpells":[[0,1,0]],"path":"res://scenes/rooms/bigJumpRoomTwo.tscn"},
	{"neededSpells":[[0,1,0]],"path":"res://scenes/rooms/bigJumpRoomThree.tscn"},
	{"neededSpells":[[1,0,0]],"path":"res://scenes/rooms/stairsroom1.tscn"},
	{"neededSpells":[[1,0,0]],"path":"res://scenes/rooms/stairsroom2.tscn"},
	{"neededSpells":[[1,0,0,1,0]],"path":"res://scenes/rooms/grapplinghookroom1.tscn"},
	{"neededSpells":[[1,0,0,1,0],[0,1,0]],"path":"res://scenes/rooms/grapplejump.tscn"}
]

func _ready() -> void:
	for I in SpellSource:
		Spells[I["code"]] = I["scene"]

func getValidRooms() -> Array[int]:
	var roomsWow : Array[int] = []
	for I in rooms:
		var valid = true
		for C in I["neededSpells"]:
			if not C in unlockedSpells:
				valid = false
		if valid: 
			if not rooms.find(I) in playedRooms:
				roomsWow.append(rooms.find(I))
	return roomsWow

func getGainableSpeller() -> Array[int]:
	var speller : Array[int] = []
	for I in SpellSource:
		if not I.get("code") in unlockedSpells:
			speller.append(SpellSource.find(I))
	return speller
