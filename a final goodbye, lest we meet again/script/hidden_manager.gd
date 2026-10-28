extends Node
class_name Hidden_Manager
static var Layer1: TileMapLayer
static var Layer2: TileMapLayer
static var Layer3: TileMapLayer
	

# Called when the node enters the scene tree for the first time.
func _ready():
	Layer1 = $Under_FG
	Layer2 = $Over_FG
	Layer3 = $"Under_FG-1"
static func amogus():
	if State.hidden == "reveal":
		#Removes the targetted layers
		Layer1.enabled = false
		Layer2.enabled = false
		Layer3.enabled = false
		print ("Huzzah... a new area has opened up!")
