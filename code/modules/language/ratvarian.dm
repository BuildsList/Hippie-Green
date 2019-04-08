/datum/language/ratvar
	name = "Ratvarian"
	desc = "A timeless language full of power and incomprehensible to the unenlightened."
	var/static/random_speech_verbs = list("звенит", "лязгает")
	ask_verb = "запрашивает"
	exclaim_verb = "возглашает"
	whisper_verb = "шепчет"
	key = "r"
	default_priority = 10
	spans = list(SPAN_ROBOT)
	icon_state = "ratvar"

/datum/language/ratvar/scramble(var/input)
	. = text2ratvar(input)

/datum/language/ratvar/get_spoken_verb(msg_end)
	if(!msg_end)
		return pick(random_speech_verbs)
	return ..()