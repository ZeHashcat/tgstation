/datum/controller/subsystem/ticker/proc/create_npc_crew()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		var/open = 0
		var/list/exceptions = list()

		if(department.department_name == "Assistant")
			continue

		for(var/datum/job/job as anything in department.department_jobs)
			if(job.total_positions == -1)
				exceptions += job.title
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

				var/mob/living/carbon/human/character = new(new_guy.mind.assigned_role.get_roundstart_spawn_point())
				character.name = new_guy.mind.name
				new_guy.mind.transfer_to(character)
				qdel(new_guy)

				open--
				CHECK_TICK

