/// Creates, assigns and returns the new_character to spawn as. Assumes a valid mind.assigned_role exists.
/mob/dead/new_player/proc/create_character_npc(mob/dead/new_player/player, atom/destination)
	spawning = TRUE
	close_spawn_windows()

	mind.active = FALSE //we wish to transfer the key manually
	var/mob/living/spawning_mob = mind.assigned_role.get_spawn_mob_npc(player, destination)
	if(!isAI(spawning_mob)) // Unfortunately there's still snowflake AI code out there.
		mind.transfer_to(spawning_mob) //won't transfer key since the mind is not active
		mind.set_original_character(spawning_mob)
		spawning_mob.ai_controller = new /datum/ai_controller/npc(spawning_mob)
	. = spawning_mob
	new_character = .
