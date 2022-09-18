//We couldn't find a job from prefs for this guy.
/datum/controller/subsystem/job/proc/HandleUnassignedNpc(mob/dead/new_player/player)

	if(PopcapReached())
		RejectPlayer(player)
		return

	if(!GiveRandomJob(player))
		RejectPlayer(player)
		return
