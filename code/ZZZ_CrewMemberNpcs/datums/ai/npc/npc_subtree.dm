/datum/ai_planning_subtree/npc_do_job/SelectBehaviors(datum/ai_controller/npc/controller, delta_time)
	var/mob/controller_pawn = controller.pawn
	var/area/this_area = get_area(controller_pawn)
	var/job_location = get_job_location(controller_pawn)

	if(this_area != get_job_area(controller_pawn))
		if(job_location == null)
			return
		controller.queue_behavior(/datum/ai_behavior/npc_goto_location, job_location)
	else
		//do job



/datum/ai_planning_subtree/proc/get_job_area(var/mob/controller_pawn)
	var/datum/job/pawn_job = controller_pawn.job

	switch(pawn_job)
		if("Captain")
			return /area/station/command/bridge
		if("Botanist")
			return /area/station/service/hydroponics

/datum/ai_planning_subtree/proc/get_job_location(var/mob/controller_pawn)
	var/datum/job/pawn_job = controller_pawn.job

	switch(pawn_job)
		if("Captain")
			return "Bridge"
		if("Botanist")
			return "Hydroponics"
