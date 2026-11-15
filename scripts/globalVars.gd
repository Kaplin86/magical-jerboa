extends Node

var currentJerboa : JerboaPlayer = null

var Spells = {}

var unlockedSpells = []

var playedRooms = []

var previousUnlockedSPells = []
signal unlockedSpellsChanged

var SpellSource = [
	{"name":"Super Jump",
	"desc":"[[color=red]A[/color],[color=blue]B[/color],[color=red]A[/color]] Propels you high into the air!",
	"code" : [0,1,0],
	"texture": preload("res://art/upgrade/bigboost.png"),
	 "scene":  preload("res://scenes/spells/superjump.tscn")},
	{"name":"Stairway Creation",
	"texture":preload("res://art/upgrade/stair.png"),
	"desc":"[[color=blue]B[/color],[color=red]A[/color],[color=red]A[/color]] Creates a stairway infront of you",
	"code" : [1,0,0],
	"scene" : preload("res://scenes/spells/stairwaycreation.tscn")
	},
	{"name":"Grappling Hook",
	"texture":preload("res://art/upgrade/grappling.png"),
	"desc":"[[color=blue]B[/color],[color=red]A[/color],[color=red]A[/color],[color=blue]B[/color],[color=red]A[/color]] Brings you UP!",
	"code" : [1,0,0,1,0],
	"scene" : preload("res://scenes/spells/grapplingHook.tscn")
	},
	{"name":"Magnetization",
	"texture":preload("res://art/upgrade/magnet.png"),
	"desc":"[[color=blue]B[/color],[color=blue]B[/color],[color=red]A[/color],[color=red]A[/color],[color=blue]B[/color],[color=blue]B[/color],[color=red]A[/color],[color=blue]B[/color]] Magnetize metal things towards you",
	"code" : [1,1,0,0,1,1,0,1],
	"scene" : preload("res://scenes/spells/magnetization.tscn")
	}
	
]

var rooms = [
	{"neededSpells":[[0,1,0]],"path":"res://scenes/rooms/bigJumpRoomOne.tscn"},
	{"neededSpells":[[0,1,0]],"path":"res://scenes/rooms/bigJumpRoomTwo.tscn"},
	{"neededSpells":[[0,1,0],[1,0,0]],"path":"res://scenes/rooms/bigJumpRoomThree.tscn"},
	{"neededSpells":[[1,0,0]],"path":"res://scenes/rooms/stairsroom1.tscn"},
	{"neededSpells":[[1,0,0]],"path":"res://scenes/rooms/stairsroom2.tscn"},
	{"neededSpells":[[1,0,0,1,0]],"path":"res://scenes/rooms/grapplinghookroom1.tscn"},
	{"neededSpells":[[1,0,0,1,0]],"path":"res://scenes/rooms/grapplinghookroom2.tscn"},
	{"neededSpells":[[1,0,0,1,0],[0,1,0]],"path":"res://scenes/rooms/grapplejump.tscn"},
	{"neededSpells":[[1,1,0,0,1,1,0,1]],"path":"res://scenes/rooms/magnetOne.tscn"},
	{"neededSpells":[[1,1,0,0,1,1,0,1]],"path":"res://scenes/rooms/magnetTwo.tscn"}

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

func _process(delta: float) -> void:
	if previousUnlockedSPells != unlockedSpells:
		previousUnlockedSPells = unlockedSpells.duplicate(true)
		unlockedSpellsChanged.emit()
