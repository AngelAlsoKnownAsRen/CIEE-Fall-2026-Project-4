extends Resource

class_name character

@export var name: String = ""
@export var Sprite: Texture2D
@export var description: String = ""
@export var max_health: int = 0
var cur_health: int
var cur_defense: int

#utility functions
func initialize():
	cur_health = max_health

func reset_def():
	cur_defense = 0;

func take_damage(damage, def_effect):
	if (damage - (cur_defense * def_effect)) > 0:
		cur_health -= damage - (cur_defense * def_effect)
	if cur_health <= 0:
		GameManager.game_over()

func begin_turn(target:character):
	attack(self, target)


func attack(owner: character, target: character):
	var rand_num: int = randi() %3
	if rand_num == 0:
		target.take_damage(10,1)
		print("Normal Attack: 10 damage!")
	elif rand_num == 1:
		target.take_damage(10,1)
		cur_defense = 5
		print("Defensive Attack: 10 damage!")
	elif rand_num == 2:
		target.take_damage(15,1)
		print("Strong Attack: 15 damage!!!")
	#GameManager.next_turn()
