extends Node
class_name Hidden_Manager
static var Map_Foreground: TileMapLayer
static var New_Foreground: TileMapLayer
static var Layer1: TileMapLayer
static var Layer2: TileMapLayer
	

# Called when the node enters the scene tree for the first time.
# To whoever is reading this: wtf did we write
func _ready():
	Map_Foreground = $"../Map_Foreground"
	New_Foreground = $Map_NewFG
	Layer1 = $Layer1
	Layer2 = $Layer2
static func amogus():
	if State.hidden == "reveal":
		#enable Hidden Layers
		New_Foreground.enabled = true
		Layer1.enabled = true
		Layer2.enabled = true
		#Disable Original Map_Foreground
		Map_Foreground.enabled = false
		print ("Huzzah... a new area has opened up!")
