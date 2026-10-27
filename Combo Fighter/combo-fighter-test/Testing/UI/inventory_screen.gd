extends Control

@onready var player: player_character
@onready var gridContainer = $ScrollContainer/GridContainer
const BUTTON_PRESET = preload("res://Testing/UI/skill_inventory_button.tscn")
var inventory = Inventory
var is_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	close()

func set_player(char: character):
	player = char
	inventory = player.skill_inventory
	update_grid()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("Inventory"):
		#if is_open:
			#close()
		#else:
			#open()
	pass
	
func open_close():
	if is_open:
		close()
	else:
		open()

"""
This script controls which buttons are shown. 
Propogates from player inventory

Can change(for readibility), that only usuable skills are shown
if player.next_combo_types.has(item.type) 
if (player.momenutm >= item.momentum_min) and (player.momentum <= item.momenutm_max)
"""
func update_grid():
	for child in gridContainer.get_children():
			child.queue_free()
	
	if inventory == null:
		return
	
	for item in inventory.InvItems:
		if item == null:
			continue
		
		var button := BUTTON_PRESET.instantiate() as Button
		button.text = item.name
		
		#button tooltip
		button.tooltip_text = "Type: " + skill_type.Type.keys()[item.type] + "\n" + "Combos into: "
		for combo_type in item.combo_types:
			button.tooltip_text = button.tooltip_text + skill_type.Type.find_key(combo_type) + " "
		button.tooltip_text = button.tooltip_text + "\n" + "Momentum Range :" + str(item.momentum_min) + "-" + str(item.momentum_max) + "\n" + " Damage: " + str(item.base_damage) + "Defense: " + str(item.base_defense) + "\n"+ item.description
		
		button.pressed.connect(_on_button_pressed.bind(item))
		gridContainer.add_child(button)
		
func _on_button_pressed(item: InvItem):
	if player != null and player.target != null:
		close()
		if item.use(player, player.target):
			#GameManager.next_turn()
			pass


func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
