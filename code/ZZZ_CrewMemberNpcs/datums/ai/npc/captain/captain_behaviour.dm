/datum/ai_behavior/npc/captain/secure_documents
	priority = 10
	//grab folder in view
	//grab spare id paper
	//copy spare id password to notes
	//put spare id paper in folder
	//grab comms doc
	//scan comms doc
	//set extra jobs based on comms doc
	//put comms doc in folder
	//put folder in bag


/datum/ai_behavior/npc/captain/comms_check_status_with_hods
	priority = 9
	//say "Heads up, Heads of departments, status check!"
	//for a small period of time, listen for response
	//give orders based on awareness of situation and priority e.g.
	//CE: "We got 4 engineers and 3 atmos techs, engine not started, primary batteries status: 32%, 51%, 33%, solars not wired, captain!"
	//Captain:"CE, Get that engine started, fill up those batteries and get those solars wired!"

/datum/ai_behavior/npc/captain/comms_damage_report
	//listen for significant reports of damage, this procs when damage is reported and captain is not critically busy.
	//say "<relevant authority that still is alive according to awareness>, damage report!"
	//for a small period of time, listen for response
	//give orders based on awareness of situation and priority e.g.
	//CE: "Hull breach(es) detected in: x, y, z!" or
	//CE: "Fire(s) detected in: x, y, z!."
	//Captain:"<order relevant action> in: x, y, z!"

/datum/ai_behavior/npc/captain/comms_medical_report
	//listen for significant incident reports, this procs when damage is reported and captain is not critically busy.
	//say "<relevant authority that still is alive according to awareness>, damage report!"
	//for a small period of time, listen for response
	//give orders based on awareness of situation and priority e.g.
	//CMO: "Currently 10 injured, 3 dead."
	//CMO: "There are currently 2 in surgery and 1 in cryo."
	//Captain:"<order relevant action> in: x, y, z!"

/datum/ai_behavior/npc/captain/comms_stock_report(var/department)//!!Change department to correct w/edit_message
	//say: "<relevant authority of department>, send me a report of your stocks."
