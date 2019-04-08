/datum/round_event_control/bureaucratic_error
	name = "Bureaucratic Error"
	typepath = /datum/round_event/bureaucratic_error
	max_occurrences = 1
	weight = 5

/datum/round_event/bureaucratic_error
	announceWhen = 1

/datum/round_event/bureaucratic_error/announce(fake)
	priority_announce("Недавняя бюрократическая ошибка Центрального Командования может вызвать переизбыток персонала одних профессий и недостаток персонала в других.", "Paperwork Mishap Alert")

/datum/round_event/bureaucratic_error/start()
	SSjob.set_overflow_role(pick(get_all_jobs()))
