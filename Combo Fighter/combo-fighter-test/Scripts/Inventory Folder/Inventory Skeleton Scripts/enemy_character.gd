extends character

class_name enemy_character

@export var str: int = 0
@export var AttackList: Array[attack]

#nothing has this class (and likely shouldn't), it's just in case we need to chnage all enemies

func attack(owner: character, target: character):
	print("SKILL USE: ", name, " | Current character: ", GameManager.cur_char.name)
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
