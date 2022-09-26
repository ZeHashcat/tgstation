/*
AI controllers are a datumized form of AI that simulates the input a player would otherwise give to a mob. What this means is that these datums
have ways of interacting with a specific mob and control it.
*/
///OOK OOK OOK

/datum/ai_controller/npc
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		//general type behaviour
			//check health
				// false = check status = being helped
					//false = check if in medbay waiting room
						//false = go to medbay waiting room
			//check mental
				//false = check if in lounge/chapel
				 	//false = go to lounge/chapel
						//lounge
							//if bartender present
								//order drink
									//drink drink slowly at bar
							//else
								//check drink showcase for drink
								//drink drink slowly at bar
							//check has cigarettes
								//true = check has lighter
									//true = smoke cigarette
										//idle
									//false = buy lighter
								//false = buy cigarettes
									//go to check has cigarettes
							//idle
						//chapel
							//pray
							//contemplate
							//converse with priest
			//check hunger
				//false = go to lounge
					//check if food available
						//true = eat food
						//false = find vendingmachine
							//buy food
								//eat food
			//check current job
				//check if at job location
					//false = go to job location
					//true = do job behaviour
		/datum/ai_planning_subtree/npc_do_job

	)
	blackboard = list()
	ai_movement = /datum/ai_movement/jps
	idle_behavior = /datum/idle_behavior/idle_npc
	var/go_to_general_area = FALSE

/datum/ai_controller/npc/process(delta_time)
	if(!able_to_run())
		SSmove_manager.stop_looping(pawn) //stop moving
		return //this should remove them from processing in the future through event-based stuff.

	if(!LAZYLEN(current_behaviors) && idle_behavior)
		idle_behavior.perform_idle_behavior(delta_time, src) //Do some stupid shit while we have nothing to do
		return

	if(current_movement_target)
		if(!isatom(current_movement_target))
			stack_trace("[pawn]'s current movement target is not an atom, rather a [current_movement_target.type]! Did you accidentally set it to a weakref?")
			CancelActions()
			return

		if(get_dist(pawn, current_movement_target) > max_target_distance) //The distance is out of range
			CancelActions()
			return

	for(var/datum/ai_behavior/current_behavior as anything in current_behaviors)

		// Convert the current behaviour action cooldown to realtime seconds from deciseconds.current_behavior
		// Then pick the max of this and the delta_time passed to ai_controller.process()
		// Action cooldowns cannot happen faster than delta_time, so delta_time should be the value used in this scenario.
		var/action_delta_time = max(current_behavior.action_cooldown * 0.1, delta_time)

		if(current_behavior.behavior_flags & AI_BEHAVIOR_REQUIRE_MOVEMENT) //Might need to move closer
			var/area/job_area = get_job_area(pawn)
			var/area/current_area = get_area(pawn)
			if(current_area.type == job_area & go_to_general_area)
				go_to_general_area = FALSE
				ai_movement.stop_moving_towards(src)

			if(!current_movement_target)
				stack_trace("[pawn] wants to perform action type [current_behavior.type] which requires movement, but has no current movement target!")
				ai_movement.stop_moving_towards(src)
				return //This can cause issues, so don't let these slide.

			if(current_behavior.required_distance >= get_dist(pawn, current_movement_target)) ///Are we close enough to engage?
				if(ai_movement.moving_controllers[src] == current_movement_target) //We are close enough, if we're moving stop.
					ai_movement.stop_moving_towards(src)

				if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
					continue

				ProcessBehavior(action_delta_time, current_behavior)
				return

			else if(ai_movement.moving_controllers[src] != current_movement_target) //We're too far, if we're not already moving start doing it.
				ai_movement.start_moving_towards(src, current_movement_target, current_behavior.required_distance) //Then start moving

			if(current_behavior.behavior_flags & AI_BEHAVIOR_MOVE_AND_PERFORM) //If we can move and perform then do so.
				if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
					continue
				ProcessBehavior(action_delta_time, current_behavior)
				return
		else //No movement required
			if(behavior_cooldowns[current_behavior] > world.time) //Still on cooldown
				continue
			ProcessBehavior(action_delta_time, current_behavior)
			return




/datum/ai_controller/npc/get_access()
	var/mob/living/carbon/human/npc = src.pawn
	return npc.wear_id

