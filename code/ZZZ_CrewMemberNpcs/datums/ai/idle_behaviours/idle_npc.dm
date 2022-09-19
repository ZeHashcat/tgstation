/datum/idle_behavior/idle_npc
///sentences that will be played commonly during idle behavior.
var/list/common_sentences = list(
	"Doop di doop di do",
	"Hi",
)
///sentences that will be played rarely during idle behavior.
var/list/rare_sentences = list(
	"Hmmpf...",
	"What to do",
	"heh",
	"Beep bep",
)

/datum/idle_behavior/idle_npc/perform_idle_behavior(delta_time, datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn

	if(DT_PROB(5, delta_time) && (living_pawn.mobility_flags & MOBILITY_MOVE) && isturf(living_pawn.loc) && !living_pawn.pulledby)
		var/move_dir = pick(GLOB.alldirs)
		living_pawn.Move(get_step(living_pawn, move_dir), move_dir)
	//else if(DT_PROB(30, delta_time))
		//living_pawn.say(pick(common_sentences))
	//else if(DT_PROB(15, delta_time))
		//living_pawn.say(pick(rare_sentences))
