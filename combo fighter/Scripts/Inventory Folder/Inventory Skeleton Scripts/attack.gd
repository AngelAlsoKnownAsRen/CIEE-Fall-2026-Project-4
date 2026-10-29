extends Resource

class_name attack
@export var name: String
@export var str: int = 0
@export var def_effect_percent: int = 1 #the effectiveness of a defensive skill uses against this
@export var def: int = 0

func use(owner: character, target: character):
	target.take_damage(str,def_effect_percent)
	owner.cur_defense = def
	print(name + " " + str(str) + " damage")
	#GameManager.next_turn()
