extends character

class_name player_character

#inventories
@export var item_inventory: Inventory
@export var skill_inventory: Inventory
@export var hand_one: InvItem #should change these to weapon_InvItem
@export var hand_two: InvItem
@export var armor: InvItem #should change these to armor_InvItem
@export var target: character
var next_combo_types: Array[skill_type.Type] = [skill_type.Type.Basic]

#stats
var cur_momentum: int = 0
var max_momentum = 100
var can_use: Array[skill_type.Type] = [skill_type.Type]

#utility methods
func set_target(enemy: character):
	target = enemy

func initialize():
	cur_health = max_health
	if (100 - hand_one.max_momentum_cost - hand_two.max_momentum_cost - armor.max_momentum_cost) > 0:
		max_momentum = 100 - hand_one.max_momentum_cost - hand_two.max_momentum_cost - armor.max_momentum_cost
	else:
		max_momentum = 0



"""
This is holdover from old code if you don't want to use the action_screen

func begin_turn():
	await GameManager.player_action
	if Input.is_action_just_pressed("1"):
		skill_inventory.InvItems[0].use(self,target)
		GameManager.next_turn()
	elif Input.is_action_just_pressed("2"):
		skill_inventory.InvItems[1].use(self,target)
		GameManager.next_turn()
	else:
		begin_turn()
"""
