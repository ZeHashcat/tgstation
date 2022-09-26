/datum/ai_behavior/npc_goto_location
	action_cooldown = 2 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/npc_goto_location/setup(datum/ai_controller/npc/controller, var/destination)
	. = ..()
	var/index = 0
	controller.max_target_distance = 500
	for(var/atom/possible_destination in GLOB.navigate_destinations)
		index++
		var/turf/src_loc = get_turf(controller.pawn)
		if(!isatom(possible_destination) || possible_destination.z != src_loc.z)
			continue
		var/destination_name = GLOB.navigate_destinations[possible_destination]
		if(destination_name == destination)
			controller.current_movement_target = GLOB.navigate_destinations[index]
			controller.go_to_general_area = TRUE
			break

/datum/ai_behavior/captain_do_job

