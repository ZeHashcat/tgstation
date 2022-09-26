/datum/ai_planning_subtree/npc_do_job/SelectBehaviors(datum/ai_controller/npc/controller, delta_time)
	var/mob/controller_pawn = controller.pawn
	var/area/this_area = get_area(controller_pawn)
	var/area/job_area = get_job_area(controller_pawn)
	var/job_location = get_job_location(controller_pawn)

	if(this_area.type != job_area)
		if(job_location == null)
			return
		controller.queue_behavior(/datum/ai_behavior/npc_goto_location, job_location)
	else
		do_job_select_profession


/datum/ai_planning_subtree/proc/get_job_area(var/mob/controller_pawn)
	switch(controller_pawn.job)
		if("Captain")
			return /area/station/command/bridge
		if("Botanist")
			return /area/station/service/hydroponics

/datum/ai_planning_subtree/proc/get_job_location(var/mob/controller_pawn)
	switch(controller_pawn.job)
		if("Captain")
			return "Bridge Center"
		if("Botanist")
			return "Hydroponics"

/datum/ai_planning_subtree/proc/do_job_select_profession(var/mob/controller_pawn, delta_time)
	switch(controller_pawn.job)
		do_job_captain(controller_pawn, delta_time)

/datum/ai_planning_subtree/proc/do_job_captain(var/mob/controller_pawn, delta_time)

	controller.queue_behavior(/datum/ai_behavior/npc_goto_location, job_location)
