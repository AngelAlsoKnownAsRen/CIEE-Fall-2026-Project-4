extends Control

@onready var player: player_character
@onready var skill_menu = $"Skill Menu"
@onready var enemy: character
var is_player_turn = false
# Called when the node enters the scene tree for the first time.
func set_player(char: player_character, e_char: character):
	player = char
	enemy = e_char
	skill_menu.set_player(player)
	skill_menu.update_grid()
	
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func begin_turn():
	is_player_turn = true

func _on_attack_button_down() -> void:
	if GameManager.cur_char == player:
		player.hand_one.basic_skill.use(player, enemy)

func _on_guard_button_down() -> void:
	if GameManager.cur_char == player:
		player.hand_one.guard_skill.use(player, enemy)


func _on_skills_button_down() -> void:
	if GameManager.cur_char == player:
		skill_menu.open_close()
