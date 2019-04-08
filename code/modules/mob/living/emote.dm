
/* EMOTE DATUMS */
/datum/emote/living
	mob_type_allowed_typecache = /mob/living
	mob_type_blacklist_typecache = list(/mob/living/simple_animal/slime, /mob/living/brain)

/datum/emote/living/blush
	key = "blush"
	key_third_person = "blushes"
	message = "краснеет."

/datum/emote/living/bow
	key = "bow"
	key_third_person = "bows"
	message = "делает поклон."
	message_param = "кланяется %t."
	restraint_check = TRUE

/datum/emote/living/burp
	key = "burp"
	key_third_person = "burps"
	message = "рыгает.."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/choke
	key = "choke"
	key_third_person = "chokes"
	message = "отчаянно хватается за горло!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cross
	key = "cross"
	key_third_person = "crosses"
	message = "скрещивает руки."
	restraint_check = TRUE

/datum/emote/living/chuckle
	key = "chuckle"
	key_third_person = "chuckles"
	message = "посмеивается."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse
	key = "collapse"
	key_third_person = "collapses"
	message = "падает!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/collapse/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Unconscious(40)

/datum/emote/living/cough
	key = "cough"
	key_third_person = "coughs"
	message = "кашляет!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/cough/can_run_emote(mob/user, status_check = TRUE)
	. = ..()
	if(user.has_trait(TRAIT_SOOTHED_THROAT))
		return FALSE

/datum/emote/living/dance
	key = "dance"
	key_third_person = "dances"
	message = "весело танцует."
	restraint_check = TRUE

/datum/emote/living/deathgasp
	key = "deathgasp"
	key_third_person = "deathgasps"
	message = "вздрагивает и безвольно падает, глаза мертвые и безжизненные..."
	message_robot = "на мгновение яростно вздрагивает, прежде чем остановится, его глаза медленно темнеют."
	message_AI = "испускает поток искр из мерцающего экрана, пока его системы медленно отключаются."
	message_alien = "испускает слабый визг, пока зеленая кровь пузырится из его пасти ..."
	message_larva = "испускает страннное шипение и безвольно падает на пол..."
	message_monkey = "испускает слабый писк в падении и перестает двигаться..."
	message_simple =  "прекращает двигаться..."
	stat_allowed = UNCONSCIOUS

/datum/emote/living/deathgasp/run_emote(mob/user, params)
	var/mob/living/simple_animal/S = user
	if(istype(S) && S.deathmessage)
		message_simple = S.deathmessage
	. = ..()
	message_simple = initial(message_simple)
	if(. && user.deathsound)
		if(isliving(user))
			var/mob/living/L = user
			if(!L.can_speak_vocal() || L.oxyloss >= 50)
				return //stop the sound if oxyloss too high/cant speak
		playsound(user, user.deathsound, 200, TRUE, TRUE)

/datum/emote/living/drool
	key = "drool"
	key_third_person = "drools"
	message = "пускает слюну."

/datum/emote/living/faint
	key = "faint"
	key_third_person = "faints"
	message = "терает сознание."

/datum/emote/living/faint/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.SetSleeping(200)

/datum/emote/living/flap
	key = "flap"
	key_third_person = "flaps"
	message = "машет крыльями."
	restraint_check = TRUE
	var/wing_time = 20

/datum/emote/living/flap/run_emote(mob/user, params)
	. = ..()
	if(. && ishuman(user))
		var/mob/living/carbon/human/H = user
		var/open = FALSE
		if(H.dna.features["wings"] != "None")
			if("wingsopen" in H.dna.species.mutant_bodyparts)
				open = TRUE
				H.CloseWings()
			else
				H.OpenWings()
			addtimer(CALLBACK(H, open ? /mob/living/carbon/human.proc/OpenWings : /mob/living/carbon/human.proc/CloseWings), wing_time)

/datum/emote/living/flap/aflap
	key = "aflap"
	key_third_person = "aflaps"
	message = "УГРОЖАЮЩЕ машет своими крыльями!"
	restraint_check = TRUE
	wing_time = 10

/datum/emote/living/frown
	key = "frown"
	key_third_person = "frowns"
	message = "хмурится."

/datum/emote/living/gag
	key = "gag"
	key_third_person = "gags"
	message = "хохмится."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/gasp
	key = "gasp"
	key_third_person = "gasps"
	message = "задыхается!"
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/giggle
	key = "giggle"
	key_third_person = "giggles"
	message = "хихикает."
	message_mime = "тихо хихикает!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/glare
	key = "glare"
	key_third_person = "glares"
	message = "смотрит с ненавистью."
	message_param = "смотрит с ненавистью на %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/grin
	key = "grin"
	key_third_person = "grins"
	message = "ухмыляется."

/datum/emote/living/groan
	key = "groan"
	key_third_person = "groans"
	message = "стонет!"
	message_mime = "пытается стонать!"

/datum/emote/living/grimace
	key = "grimace"
	key_third_person = "grimaces"
	message = "кривляется."

/datum/emote/living/jump
	key = "jump"
	key_third_person = "jumps"
	message = "прыгает!"
	restraint_check = TRUE

/datum/emote/living/kiss
	key = "kiss"
	key_third_person = "kisses"
	message = "посылает воздушный поцелуй."
	message_param = "посылает воздушный поцелуй %t."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "смеется."
	message_mime = "тихо хихикает!"
	emote_type = EMOTE_AUDIBLE
	vary = TRUE

/datum/emote/living/laugh/can_run_emote(mob/living/user, status_check = TRUE)
	. = ..()
	if(. && iscarbon(user))
		var/mob/living/carbon/C = user
		return !C.silent

/datum/emote/living/laugh/get_sound(mob/living/user)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.dna.species.id == "human" && (!H.mind || !H.mind.miming))
			if(user.gender == FEMALE)
				return 'sound/voice/human/womanlaugh.ogg'
			else
				return pick('sound/voice/human/manlaugh1.ogg', 'sound/voice/human/manlaugh2.ogg')

/datum/emote/living/look
	key = "look"
	key_third_person = "looks"
	message = "наблюдает."
	message_param = "наблюдает за  %t."

/datum/emote/living/nod
	key = "nod"
	key_third_person = "nods"
	message = "кивает."
	message_param = "кивает %t."

/datum/emote/living/point
	key = "point"
	key_third_person = "points"
	message = "указывает."
	message_param = "указывает на %t."
	restraint_check = TRUE

/datum/emote/living/point/run_emote(mob/user, params)
	message_param = initial(message_param) // reset
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(H.get_num_arms() == 0)
			if(H.get_num_legs() != 0)
				message_param = "tries to point at %t with a leg, <span class='userdanger'>falling down</span> in the process!"
				H.Paralyze(20)
			else
				message_param = "<span class='userdanger'>bumps [user.p_their()] head on the ground</span> trying to motion towards %t."
				H.adjustBrainLoss(5)
	..()

/datum/emote/living/pout
	key = "pout"
	key_third_person = "pouts"
	message = "надувает губы."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scream
	key = "scream"
	key_third_person = "screams"
	message = "кричит!"
	message_mime = "застыл в гримасе крика!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/scowl
	key = "scowl"
	key_third_person = "scowls"
	message = "мурится."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shake
	key = "shake"
	key_third_person = "shakes"
	message = "трясет своей головой."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/shiver
	key = "shiver"
	key_third_person = "shiver"
	message = "дрожит."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sigh
	key = "sigh"
	key_third_person = "sighs"
	message = "вздыхает."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/sit
	key = "sit"
	key_third_person = "sits"
	message = "садится."

/datum/emote/living/smile
	key = "smile"
	key_third_person = "smiles"
	message = "улыбается."

/datum/emote/living/sneeze
	key = "sneeze"
	key_third_person = "sneezes"
	message = "чихает."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/smug
	key = "smug"
	key_third_person = "smugs"
	message = "самодовольно улыбается."

/datum/emote/living/sniff
	key = "sniff"
	key_third_person = "sniffs"
	message = "принюхивается."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snore
	key = "snore"
	key_third_person = "snores"
	message = "храпит."
	message_mime = "крепко спит."
	emote_type = EMOTE_AUDIBLE
	stat_allowed = UNCONSCIOUS

/datum/emote/living/stare
	key = "stare"
	key_third_person = "stares"
	message = "глазеет."
	message_param = "глазеет на %t."

/datum/emote/living/strech
	key = "stretch"
	key_third_person = "stretches"
	message = "вытягивает руки."

/datum/emote/living/sulk
	key = "sulk"
	key_third_person = "sulks"
	message = "грустит в печали."

/datum/emote/living/surrender
	key = "surrender"
	key_third_person = "surrenders"
	message = "кладет руки за голову и падает на землю, он сдается!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/surrender/run_emote(mob/user, params)
	. = ..()
	if(. && isliving(user))
		var/mob/living/L = user
		L.Paralyze(200)

/datum/emote/living/sway
	key = "sway"
	key_third_person = "sways"
	message = "головокружительно кружится."

/datum/emote/living/tremble
	key = "tremble"
	key_third_person = "trembles"
	message = "дрожит в страхе!"

/datum/emote/living/twitch
	key = "twitch"
	key_third_person = "twitches"
	message = "яростно дергается."

/datum/emote/living/twitch_s
	key = "twitch_s"
	message = "дергается."

/datum/emote/living/wave
	key = "wave"
	key_third_person = "waves"
	message = "мешается."

/datum/emote/living/whimper
	key = "whimper"
	key_third_person = "whimpers"
	message = "хнычет."
	message_mime = "скорчил гримасу боли."

/datum/emote/living/wsmile
	key = "wsmile"
	key_third_person = "wsmiles"
	message = "слабо улыбается."

/datum/emote/living/yawn
	key = "yawn"
	key_third_person = "yawns"
	message = "зевает."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/custom
	key = "me"
	key_third_person = "custom"
	message = null

/datum/emote/living/custom/proc/check_invalid(mob/user, input)
	. = TRUE
	if(copytext(input,1,5) == "говорит")
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
	else if(copytext(input,1,9) == "восклицает")
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
	else if(copytext(input,1,6) == "кричит")
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
	else if(copytext(input,1,5) == "спрашивает")
		to_chat(user, "<span class='danger'>Invalid emote.</span>")
	if(is_banned_from(user.ckey, "Emote"))
		. = FALSE

/datum/emote/living/custom/run_emote(mob/user, params, type_override = null)
	if(is_banned_from(user.ckey, "Emote"))
		to_chat(user, "Вы не можете отправлять эмоуты (бан).")
		return FALSE
	else if(QDELETED(user))
		return FALSE
	else if(user.client && user.client.prefs.muted & MUTE_IC)
		to_chat(user, "Вы не можете писать в IC чат (мут)")
		return FALSE
	else if(!params)
		var/custom_emote = copytext(sanitize(input("Выберите эмоуты для отображения.") as text|null), 1, MAX_MESSAGE_LEN)
		if(custom_emote && !check_invalid(user, custom_emote))
			var/type = input("Эмоция видимая или слышимаая?") as null|anything in list("Видимая", "Слышимая")
			switch(type)
				if("Видимая")
					emote_type = EMOTE_VISIBLE
				if("Слышимая")
					emote_type = EMOTE_AUDIBLE
				else
					alert("Невозможно отобразить эту эмоцию, она должна быть видимой или слышимой.")
					return
			message = custom_emote
	else
		message = params
		if(type_override)
			emote_type = type_override
	. = ..()
	message = null
	emote_type = EMOTE_VISIBLE

/datum/emote/living/custom/replace_pronoun(mob/user, message)
	return message

/datum/emote/living/help
	key = "help"

/datum/emote/living/help/run_emote(mob/user, params)
	var/list/keys = list()
	var/list/message = list("Доступные эмоции, вы можете воспользоваться ими введя \"*emote\": ")

	var/datum/emote/E
	var/list/emote_list = E.emote_list
	for(var/e in emote_list)
		if(e in keys)
			continue
		E = emote_list[e]
		if(E.can_run_emote(user, status_check = FALSE))
			keys += E.key

	keys = sortList(keys)

	for(var/emote in keys)
		if(LAZYLEN(message) > 1)
			message += ", [emote]"
		else
			message += "[emote]"

	message += "."

	message = jointext(message, "")

	to_chat(user, message)

/datum/emote/beep
	key = "beep"
	key_third_person = "beeps"
	message = "сигналит."
	message_param = "сигналит на %t."
	sound = 'sound/machines/twobeep.ogg'
	mob_type_allowed_typecache = list(/mob/living/brain, /mob/living/silicon)

/datum/emote/living/circle
	key = "circle"
	key_third_person = "circles"
	restraint_check = TRUE

/datum/emote/living/circle/run_emote(mob/user, params)
	. = ..()
	var/obj/item/circlegame/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, "<span class='notice'>Вы вращайте своей рукой.</span>")
	else
		qdel(N)
		to_chat(user, "<span class='warning'>У вас должны быть свободные руки, чтобы вращать ими.</span>")

/datum/emote/living/slap
	key = "slap"
	key_third_person = "slaps"
	restraint_check = TRUE

/datum/emote/living/slap/run_emote(mob/user, params)
	. = ..()
	if(!.)
		return
	var/obj/item/slapper/N = new(user)
	if(user.put_in_hands(N))
		to_chat(user, "<span class='notice'>Вы готовы дать пощечину.</span>")
	else
		to_chat(user, "<span class='warning'>Вы не можете никого слапать в текущем положении.</span>")
