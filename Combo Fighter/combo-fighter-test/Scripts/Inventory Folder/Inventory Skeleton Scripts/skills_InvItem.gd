extends InvItem

class_name skill

#skill types
@export var type: skill_type.Type
@export var combo_types: Array[skill_type.Type]

#stats
@export var base_damage: int = 0
@export var base_defense: int = 0
@export var def_effect_percent: float = 1 #the effectiveness of a defensive skill uses against this

#momentum
@export var momentum_min: int = 0
@export var momentum_max: int = 1
@export var momentum_gain: int = 0

func use(owner:character, target: character) -> bool:
	print("SKILL USE: ", name, " | Current character: ", GameManager.cur_char.name)
	if (GameManager.cur_char == owner):
		if (type in owner.next_combo_types):
			if (owner.cur_momentum >= momentum_min) and (owner.cur_momentum <= momentum_max):
				print(name)
				#deals with the numerical effects of a skill
				target.take_damage(base_damage,def_effect_percent)
				owner.cur_defense += base_defense
				
				#deals with momentum
				if (type == skill_type.Type.Basic) or (owner.cur_momentum > owner.max_momentum):
					owner.cur_momentum = 0
				owner.cur_momentum += momentum_gain
				
				#sets available combo types
				owner.next_combo_types = combo_types.duplicate()
				owner.next_combo_types.append(skill_type.Type.Basic)
				
				#starts next turn (the only thing that starts a turn cycle atm
				GameManager.next_turn()
				return true
			else:
				print("Not in momentum range, try again")
				return false
		else:
			print("Not a valid type")
			return false
	else:
		print("Not your turn")
		return false
