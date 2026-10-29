extends Control
"""
#This system works as a serious of nested menus. 
It goes Battle Screen -> Action Screen -> Inventory Screen (also called Skill Inventory)
It is missing an item menu, but that can be made with just a repeat of the skill inventory and some tweaks
This is passed a player and an enemy on export, you should probably change that
The action screen, not the player script, controls attacks. That is because I didn't want to add a player node, you can porbably change that now

The GameManager script controls the turn order, it gets passed the player and enemy from the battle screen.
That can probably be changed, but not necessary.

The actual internal numbers are controlled by a serious of classes
There are 4 main classes, character, InvItem, Inventory, and Attack
character and it's children are the individual fighters
InvItem and it's children are the items and skills a player can use
Inventory is just an array that holds InvItems
Attack is the attacks enemies use.
"""
@export var player: player_character
@export var enemy: character
@onready var action_screen = $"CenterContainer/Action Screen"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.set_target(enemy)
	BattleManager.battle_screen = $"."
	BattleManager.set_player(player)
	BattleManager.set_enemy(enemy)
	BattleManager.next_turn()
	action_screen.set_player(player, enemy)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#update_data()
	pass

func update_data():
	$"Player Health".text = str(player.name) + " health: " + str(player.cur_health)
	$"Enemy Health".text = str(enemy.name) + " health: " + str(enemy.cur_health)
	$"Player Momentum".text = str(player.name) + " momentum: " + str(player.cur_momentum)
	$"Enemy Defense".text = str(enemy.name) + " defense: " + str(enemy.cur_defense)
	update_usable_skills()

func update_usable_skills():
	if (player.next_combo_types.has(skill_type.Type.Slash)):
		$"Usable Skill Types/Slash Sprite".visible = true
	else:
		$"Usable Skill Types/Slash Sprite".visible = false
	if (player.next_combo_types.has(skill_type.Type.Thrust)):
		$"Usable Skill Types/Thrust Sprite".visible = true
	else:
		$"Usable Skill Types/Thrust Sprite".visible = false	
	if (player.next_combo_types.has(skill_type.Type.Parry)):
		$"Usable Skill Types/Parry Sprite".visible = true
	else:
		$"Usable Skill Types/Parry Sprite".visible = false
	if (player.next_combo_types.has(skill_type.Type.Hook)):
		$"Usable Skill Types/Hook Sprite".visible = true
	else:
		$"Usable Skill Types/Hook Sprite".visible = false
	if (player.next_combo_types.has(skill_type.Type.Swipe)):
		$"Usable Skill Types/Swipe Sprite".visible = true
	else:
		$"Usable Skill Types/Swipe Sprite".visible = false
	if (player.next_combo_types.has(skill_type.Type.Finisher)):
		$"Usable Skill Types/Finisher Sprite".visible = true
	else:
		$"Usable Skill Types/Finisher Sprite".visible = false
