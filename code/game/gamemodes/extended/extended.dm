/datum/game_mode/extended
	name = "secret extended"
	config_tag = "secret_extended"
	report_type = "extended"
	false_report_weight = 5
	required_players = 0

	announce_span = "notice"
	announce_text = "������  �������� � ����������� �����"

/datum/game_mode/extended/pre_setup()
	return 1

/datum/game_mode/extended/generate_report()
	return "� �������� �� ����������� ��� ������. ������ �����, �� ����� ����� ��� ������ �� ��������"

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
	priority_announce("��������� ��������� ������ ����� ������� �������� � ������������, � ��������� ����� ��� ������� ������ ����� ��� [station_name()]. ����������� ������� ��������� � ����������. �������� �����!", "����� ������ ������������", 'sound/ai/commandreport.ogg')
