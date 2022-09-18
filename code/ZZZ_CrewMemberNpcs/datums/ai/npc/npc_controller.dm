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
	//idle_behavior = /datum/idle_behavior/idle_npc

/datum/ai_controller/npc/get_access()
	var/mob/living/carbon/human/npc = src.pawn
	return npc.wear_id



