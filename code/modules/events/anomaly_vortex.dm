/datum/round_event_control/anomaly/anomaly_vortex
	name = "Anomaly: Vortex"
	typepath = /datum/round_event/anomaly/anomaly_vortex

	min_players = 20
	max_occurrences = 2
	weight = 5

/datum/round_event/anomaly/anomaly_vortex
	startWhen = 10
	announceWhen = 3
	anomaly_path = /obj/effect/anomaly/bhole

/datum/round_event/anomaly/anomaly_vortex/announce(fake)
	priority_announce("Сканеры дальнего действия локализовали местонахождение сверхинтесивной ворекс-аномалии. Примерное местонахождение:[impact_area.name]", "Anomaly Alert")