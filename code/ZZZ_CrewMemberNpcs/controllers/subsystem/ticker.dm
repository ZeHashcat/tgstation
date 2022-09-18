/datum/controller/subsystem/ticker/proc/create_npc_crew()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		var/open = 0

		if(department.department_name != "Service")
			CHECK_TICK
			continue

		for(var/datum/job/job as anything in department.department_jobs)
			if(job.total_positions == -1)
				continue

			var/open_slots = job.total_positions - job.current_positions
			if(open_slots < 1)
				continue
			open += open_slots

			while (open != 0)

				// JOB_CREW_MEMBER is all jobs that pretty much aren't silicon
				if(!(job.job_flags & JOB_CREW_MEMBER))
					continue

				// Create our new_player for this job and set up its mind.
				var/mob/dead/new_player/new_guy = new()
				new_guy.mind_initialize()
				new_guy.mind.name = "[job] NPC"

				if(!SSjob.AssignRole(new_guy, job))
					qdel(new_guy)
					to_chat("[job] wasn't able to be spawned.")
					continue

				var/atom/destination = new_guy.mind.assigned_role.get_roundstart_spawn_point()
				var/mob/living/carbon/human/character = new(destination)
				character.name = new_guy.mind.name
				new_guy.mind.transfer_to(character)
				qdel(new_guy)

				SSticker.minds += character.mind

				open--
		CHECK_TICK

/datum/controller/subsystem/ticker/proc/create_npc_players()
	var/open = 0
	var/real_players = GLOB.player_list.len

	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		for(var/datum/job/job as anything in department.department_jobs)
			if(job.type == /datum/job/assistant)
				continue

			if(job.total_positions == -1)
				continue

			open += job.total_positions

			while (open != 0)
				if(real_players != 0)
					real_players--
					open--
					continue

				var/mob/dead/new_player/player = new()
				player.name = "Station Crewmember"
				player.ready = PLAYER_READY_TO_PLAY
				player.mind_initialize()
				player.mind.name = "Station Crewmember NPC"

				open--






