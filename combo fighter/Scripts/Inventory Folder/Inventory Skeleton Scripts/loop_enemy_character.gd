extends enemy_character

class_name loop_enemy_character

"""
This class is for enemies that will loop through their attacks in a specific order
It will go through each of it's attacks in the order they appear in the array
"""

var round: int = 0

func attack(owner: character, target:character):
	if AttackList[round] != null:
		AttackList[round].use(owner, target)
		round += 1
	if round >= AttackList.size():
		round = 0
