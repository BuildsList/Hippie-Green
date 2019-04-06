/proc/log_mentor(text)
	GLOB.mentorlog.Add(text)
	WRITE_FILE(GLOB.world_game_log, "MENTOR: [text]")