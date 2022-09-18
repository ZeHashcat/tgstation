/// Spawns the mob to be played as, taking into account preferences and the desired spawn point.
/datum/job/proc/get_spawn_mob_npc(mob/dead/new_player/player, atom/spawn_point)
	var/mob/living/spawn_instance
	if(ispath(spawn_type, /mob/living/silicon/ai))
		// This is unfortunately necessary because of snowflake AI init code. To be refactored.
		spawn_instance = new spawn_type(get_turf(spawn_point), null, player)
	else
		spawn_instance = new spawn_type(player.loc)
		spawn_point.JoinPlayerHere(spawn_instance, TRUE)
	spawn_instance.apply_prefs_job_npc(src)
	return spawn_instance

/// Applies the preference options to the spawning mob, taking the job into account. Assumes the client has the proper mind.
/mob/living/proc/apply_prefs_job_npc(mob/dead/new_player/player, datum/job/job)

/mob/living/carbon/human/apply_prefs_job_npc(datum/job/job)
	var/require_human = CONFIG_GET(flag/enforce_human_authority) && (job.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
	if(require_human)
		var/all_authority_require_human = CONFIG_GET(flag/enforce_human_authority_on_everyone)
		if(!all_authority_require_human && job.ignore_human_authority)
			require_human = FALSE

	src.job = job.title

	if(require_human)
		randomize_human_appearance(~RANDOMIZE_SPECIES)
	else
		randomize_human_appearance()

	if (require_human)
		set_species(/datum/species/human)
		dna.species.roundstart_changed = TRUE

	if(GLOB.current_anonymous_theme)
		fully_replace_character_name(null, GLOB.current_anonymous_theme.anonymous_name(src))
	dna.update_dna_identity()
