extends Node

#var battle_screen = "res://combo fighter/Testing/UI/battle_screen.tscn"
const battle_screen_path: String = "res://combo fighter/Testing/UI/battle_screen.tscn"
var battle_screen: Node

var turn_call_id: int = 0
@onready var player = $".".player
@onready var enemy 
var cur_char = enemy
#signal player_action

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if Input.is_anything_pressed():
		#player_action.emit()
	pass

func start_fight(path:String):
	var enemy_data = load(path) as enemy_character

	if enemy_data == null:
		push_error("Failed to load enemy: " + path)
		return

	enemy = enemy_data
	cur_char = enemy
	get_tree().change_scene_to_file(battle_screen_path)
	#await get_tree().scene_changed
	battle_screen = get_tree().current_scene
	player.initialize()
	player.set_target(enemy)
	enemy.initialize()
	
func set_player(char: character):
	player = char
	player.initialize()

func set_enemy(char: character):
	enemy = char
	enemy.initialize()

"""
The next_turn function will do an enemy turn -> player turn, when called.
It will skip the enemy turn if cur_char is set to enemy when called.

The next_turn function calls a script in the enemy chracter that causes it to attack
It, however, DOES NOT call a player function to attack. It just allows the player to select an input
The call for next_turn is actually buried in skill.use().

end_of_round resets defense player defense after an enemy attacks.
The print in the output is a little funky since what the player experiences as a round is actually the last half of one turn and the second half of the next.


The player always goes first here, change change that by setting the inital cur_char to player
If we want to be able to use multiple skills in a turn, I'd recommend the .use() function also pass a boolean that allows it to call next turn, and an increment to lower an int that controls how many times a skill procs.
"""

func next_turn():
	turn_call_id += 1
	var id = turn_call_id
	print("*************************")
	print("[Turn %d] START — cur_char: %s" % [id, cur_char.name if cur_char else "null"])

	
	battle_screen.update_data()
	if player!= null and enemy != null:
		print(str(player.name) + " health: " + str(player.cur_health))
		print(str(enemy.name) + " health: " + str(enemy.cur_health))
		print("-------------------------")
	
	#enemy turn
	if cur_char == player:
		cur_char = enemy
		print("Enemy Turn")
		get_tree().paused = true
		await get_tree().create_timer(randf_range(.5,1.5)).timeout
		enemy.begin_turn(player)
		battle_screen.update_data()
		print("-------------------------")
		end_of_round()
	
	#player turn
	cur_char = player
	print("Player Turn")
	print(str(player.name) + " momentum: " + str(player.cur_momentum))
	for combo_type in player.next_combo_types:
		print(skill_type.Type.find_key(combo_type))
	get_tree().paused = false
	
func end_of_round():
	player.reset_def()

func game_over():
	get_tree().change_scene_to_file("res://scene/test_level/test_level.tscn")
	#get_tree().quit()
