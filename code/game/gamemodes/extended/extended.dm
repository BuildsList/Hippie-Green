/datum/game_mode/extended
	name = "secret extended"
	config_tag = "secret_extended"
	report_type = "extended"
	false_report_weight = 5
	required_players = 0

	announce_span = "notice"
	announce_text = "Просто  веселись и наслаждайся игрой"

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return "В передаче не упоминается ваш сектор. Скорее всего, во время смены вам ничего не угрожает"

/datum/game_mode/extended/announced
	name = "extended"
	config_tag = "extended"
	false_report_weight = 0

/datum/game_mode/extended/announced/generate_station_goals()
	for(var/T in subtypesof(/datum/station_goal))
		var/datum/station_goal/G = new T
		station_goals += G
		G.on_report()

/datum/game_mode/extended/announced/send_intercept(report = 0)
	priority_announce("Благодаря усиленной работе нашей команды разведки и безопасности, в настоящее время нет никаких прямых угроз для [station_name()]. Конструкция станции проверена и утверждена. Приятной смены!", "Отчет Отдела Безопасности", 'sound/ai/commandreport.ogg')
