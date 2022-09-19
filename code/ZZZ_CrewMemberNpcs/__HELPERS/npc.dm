/proc/get_job_area(var/mob/controller_pawn)
	var/datum/job/pawn_job = controller_pawn.job

	switch(pawn_job)
		if("Captain")
			return /area/station/command/bridge
		if("Botanist")
			return /area/station/service/hydroponics
