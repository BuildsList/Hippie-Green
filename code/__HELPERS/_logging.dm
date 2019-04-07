//wrapper macros for easier grepping
#define DIRECT_OUTPUT(A, B) A << B
#define SEND_IMAGE(target, image) DIRECT_OUTPUT(target, image)
#define SEND_SOUND(target, sound) DIRECT_OUTPUT(target, sound)
#define SEND_TEXT(target, text) DIRECT_OUTPUT(target, text)
#define WRITE_FILE(file, text) DIRECT_OUTPUT(file, text)
#define WRITE_LOG(log, text) rustg_log_write(log, text)

//print a warning message to world.log
#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
/proc/warning(msg)
	msg = "## WARNING: [msg]"
	log_world(msg)

//not an error or a warning, but worth to mention on the world log, just in case.
#define NOTICE(MSG) notice(MSG)
/proc/notice(msg)
	msg = "## NOTICE: [msg]"
	log_world(msg)

//print a testing-mode debug message to world.log and world
#ifdef TESTING
#define testing(msg) log_world("## TESTING: [msg]"); to_chat(world, "## TESTING: [msg]")
#else
#define testing(msg)
#endif

#ifdef UNIT_TESTS
/proc/log_test(text)
	WRITE_FILE(GLOB.test_log, "\[[time_stamp()]]: [text]")
	SEND_TEXT(world.log, text)
#endif


/* Items with ADMINPRIVATE prefixed are stripped from public logs. */
/proc/log_admin(text)
	GLOB.admin_log.Add(text)
	webhook_send_garbage("ADMIN", text)
	if (CONFIG_GET(flag/log_admin))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]ADMIN: [text]")

/proc/log_admin_private(text)
	GLOB.admin_log.Add(text)
	if (CONFIG_GET(flag/log_admin))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]ADMINPRIVATE: [text]")

/proc/log_adminsay(text)
	GLOB.admin_log.Add(text)
	if (CONFIG_GET(flag/log_adminchat))
		log_admin_private("ASAY: [text]")

/proc/log_dsay(text)
	if (CONFIG_GET(flag/log_adminchat))
		log_admin("DSAY: [text]")


/* All other items are public. */
/proc/log_game(text)
	if (CONFIG_GET(flag/log_game))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]GAME: [text]")

/proc/log_mecha(text)
	if (CONFIG_GET(flag/log_mecha))
		WRITE_FILE(GLOB.world_mecha_log, "\[[time_stamp()]]MECHA: [text]")

/proc/log_virus(text)
	if (CONFIG_GET(flag/log_virus))
		WRITE_FILE(GLOB.world_virus_log, "\[[time_stamp()]]VIRUS: [text]")

/proc/log_cloning(text, mob/initiator)
	if(CONFIG_GET(flag/log_cloning))
		WRITE_FILE(GLOB.world_cloning_log, "\[[time_stamp()]]CLONING: [text]")

/proc/log_asset(text)
	WRITE_FILE(GLOB.world_asset_log, "\[[time_stamp()]]ASSET: [text]")

/proc/log_access(text)
	if (CONFIG_GET(flag/log_access))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]ACCESS: [text]")

/proc/log_law(text)
	if (CONFIG_GET(flag/log_law))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]LAW: [text]")

/proc/log_attack(text)
	if (CONFIG_GET(flag/log_attack))
		WRITE_FILE(GLOB.world_attack_log, "\[[time_stamp()]]ATTACK: [text]")

/proc/log_manifest(ckey, datum/mind/mind,mob/body, latejoin = FALSE)
	if (CONFIG_GET(flag/log_manifest))
		WRITE_FILE(GLOB.world_manifest_log, "\[[time_stamp()]][ckey] \\ [body.real_name] \\ [mind.assigned_role] \\ [mind.special_role ? mind.special_role : "NONE"] \\ [latejoin ? "LATEJOIN":"ROUNDSTART"]")

/proc/log_bomber(atom/user, details, atom/bomb, additional_details, message_admins = TRUE)
	var/bomb_message = "[details][bomb ? " [bomb.name] at [AREACOORD(bomb)]": ""][additional_details ? " [additional_details]" : ""]."

	if(user)
		user.log_message(bomb_message, LOG_GAME) //let it go to individual logs as well as the game log
		bomb_message = "[key_name(user)] at [AREACOORD(user)] [bomb_message]"
	else
		log_game(bomb_message)

	GLOB.bombers += bomb_message

	if(message_admins)
		message_admins("[user ? "[ADMIN_LOOKUPFLW(user)] at [ADMIN_VERBOSEJMP(user)] " : ""][details][bomb ? " [bomb.name] at [ADMIN_VERBOSEJMP(bomb)]": ""][additional_details ? " [additional_details]" : ""].")

/proc/log_say(text)
	if (CONFIG_GET(flag/log_say))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]SAY: [text]")

/proc/log_ooc(text)
	if (CONFIG_GET(flag/log_ooc))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]OOC: [text]")

/proc/log_whisper(text)
	if (CONFIG_GET(flag/log_whisper))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]WHISPER: [text]")

/proc/log_emote(text)
	if (CONFIG_GET(flag/log_emote))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]EMOTE: [text]")

/proc/log_prayer(text)
	if (CONFIG_GET(flag/log_prayer))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]PRAY: [text]")

/proc/log_pda(text)
	if (CONFIG_GET(flag/log_pda))
		WRITE_FILE(GLOB.world_pda_log, "\[[time_stamp()]]PDA: [text]")

/proc/log_comment(text)
	if (CONFIG_GET(flag/log_pda))
		//reusing the PDA option because I really don't think news comments are worth a config option
		WRITE_FILE(GLOB.world_pda_log, "\[[time_stamp()]]COMMENT: [text]")

/proc/log_telecomms(text)
	if (CONFIG_GET(flag/log_telecomms))
		WRITE_FILE(GLOB.world_telecomms_log, "\[[time_stamp()]]TCOMMS: [text]")

/proc/log_chat(text)
	if (CONFIG_GET(flag/log_pda))
		//same thing here
		WRITE_FILE(GLOB.world_pda_log, "\[[time_stamp()]]CHAT: [text]")

/proc/log_vote(text)
	if (CONFIG_GET(flag/log_vote))
		WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]VOTE: [text]")


/proc/log_topic(text)
	WRITE_FILE(GLOB.world_game_log, "\[[time_stamp()]]TOPIC: [text]")

/proc/log_href(text)
	WRITE_FILE(GLOB.world_href_log, "\[[time_stamp()]]HREF: [text]")

/proc/log_sql(text)
	WRITE_FILE(GLOB.sql_error_log, "\[[time_stamp()]]SQL: [text]")

/proc/log_qdel(text)
	WRITE_FILE(GLOB.world_qdel_log, "\[[time_stamp()]]QDEL: [text]")

/proc/log_query_debug(text)
	WRITE_FILE(GLOB.query_debug_log, "\[[time_stamp()]]SQL: [text]")

/proc/log_job_debug(text)
	if (CONFIG_GET(flag/log_job_debug))
		WRITE_FILE(GLOB.world_job_debug_log, "\[[time_stamp()]]JOB: [text]")

/* Log to both DD and the logfile. */
/proc/log_world(text)
#ifdef USE_CUSTOM_ERROR_HANDLER
	WRITE_FILE(GLOB.world_runtime_log, "\[[time_stamp()]]: [text]")
#endif
	SEND_TEXT(world.log, text)

/* Log to the logfile only. */
/proc/log_runtime(text)
	WRITE_FILE(GLOB.world_runtime_log, "\[[time_stamp()]]: [text]")

/* Rarely gets called; just here in case the config breaks. */
/proc/log_config(text)
	WRITE_FILE(GLOB.config_error_log, "\[[time_stamp()]]: [text]")
	SEND_TEXT(world.log, text)


/* For logging round startup. */
/proc/start_log(log)
	WRITE_FILE(log, "Starting up round ID [GLOB.round_id].\n-------------------------")

/* Close open log handles. This should be called as late as possible, and no logging should hapen after. */
/proc/shutdown_logging()
	rustg_log_close_all()


/* Helper procs for building detailed log lines */
/proc/key_name(whom, include_link = null, include_name = TRUE)
	var/mob/M
	var/client/C
	var/key
	var/ckey
	var/fallback_name

	if(!whom)
		return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
		ckey = C.ckey
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
		ckey = M.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		C = GLOB.directory[ckey]
		if(C)
			M = C.mob
	else if(istype(whom,/datum/mind))
		var/datum/mind/mind = whom
		key = mind.key
		ckey = ckey(key)
		if(mind.current)
			M = mind.current
			if(M.client)
				C = M.client
		else
			fallback_name = mind.name
	else // Catch-all cases if none of the types above match
		var/swhom = null

		if(istype(whom, /atom))
			var/atom/A = whom
			swhom = "[A.name]"
		else if(istype(whom, /datum))
			swhom = "[whom]"

		if(!swhom)
			swhom = "*invalid*"

		return "\[[swhom]\]"

	. = ""

	if(!ckey)
		include_link = FALSE

	if(key)
		if(C && C.holder && C.holder.fakekey && !include_name)
			if(include_link)
				. += "<a href='?priv_msg=[C.findStealthKey()]'>"
			. += "Administrator"
		else
			if(include_link)
				. += "<a href='?priv_msg=[ckey]'>"
			. += key
		if(!C)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_name)
		if(M)
			if(M.real_name)
				. += "/([M.real_name])"
			else if(M.name)
				. += "/([M.name])"
		else if(fallback_name)
			. += "/([fallback_name])"

	return .

/proc/key_name_admin(whom, include_name = TRUE)
	return key_name(whom, TRUE, include_name)

/proc/loc_name(atom/A)
	if(!istype(A))
		return "(INVALID LOCATION)"

	var/turf/T = A
	if (!istype(T))
		T = get_turf(A)

	if(istype(T))
		return "([AREACOORD(T)])"
	else if(A.loc)
		return "(UNKNOWN (?, ?, ?))"
