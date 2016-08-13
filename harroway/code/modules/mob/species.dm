

/datum/species/monkey/vulpkanin
	name = "Wolpin"
	name_plural = "Wolpin"

	icobase = 'harroway/icons/mob/r_wolpin.dmi'
	deform = 'harroway/icons/mob/r_wolpin.dmi'

	greater_form = "Vulpkanin"
	default_language = "Wolpin"
	flesh_color = "#966464"
	base_color = "#000000"
	tail = "wolpintail"


/datum/language/vulpkanin/monkey
	name = "Wolpin"
	desc = "Bark bark bark."
	key = "vu"

/datum/language/vulpkanin
	name = "Canilunzt"
	desc = "The guttural language spoken and utilized by the inhabitants of Vazzend system, composed of growls, barks, yaps, and heavy utilization of ears and tail movements.Vulpkanin speak this language with ease."
	speech_verb = "rawrs"
	ask_verb = "rurs"
	exclaim_verb = "barks"
	colour = "vulpkanin"
	key = "7"
	flags = RESTRICTED
	syllables = list("rur","ya","cen","rawr","bar","kuk","tek","qat","uk","wu","vuh","tah","tch","schz","auch", \
	"ist","ein","entch","zwichs","tut","mir","wo","bis","es","vor","nic","gro","lll","enem","zandt","tzch","noch", \
	"hel","ischt","far","wa","baram","iereng","tech","lach","sam","mak","lich","gen","or","ag","eck","gec","stag","onn", \
	"bin","ket","jarl","vulf","einech","cresthz","azunein","ghzth")



/datum/species/vulpkanin
	name = "Vulpkanin"
	name_plural = "Vulpkanin"
	icobase = 'harroway/icons/mob/r_vulpkanin.dmi'
	deform = 'harroway/icons/mob/r_vulpkanin.dmi'
	//path = /mob/living/carbon/human/vulpkanin
	default_language = "Galactic Common"
	language = "Canilunzt"
	primitive_form = "Wolpin"
	tail = "vulptail"
	//unarmed_type = /datum/unarmed_attack/claws
	darksight = 8
	slowdown = -0.5
	brute_mod = 1.15
	burn_mod =  1.15
	gluttonous = GLUT_TINY
	num_alternate_languages = 2
	secondary_langs = list(LANGUAGE_VULP)
	name_language = LANGUAGE_VULP
	health_hud_intensity = 1.75

	min_age = 17
	max_age = 80

	blurb = "Vulpkanin are a species of sharp-witted canine-pideds residing on the planet Altam just barely within the \
	dual-star Vazzend system. Their politically de-centralized society and independent natures have led them to become a species and \
	culture both feared and respected for their scientific breakthroughs. Discovery, loyalty, and utilitarianism dominates their lifestyles \
	to the degree it can cause conflict with more rigorous and strict authorities. They speak a guttural language known as 'Canilunzt' \
    which has a heavy emphasis on utilizing tail positioning and ear twitches to communicate intent."

	spawn_flags = CAN_JOIN | IS_WHITELISTED
	appearance_flags = HAS_HAIR_COLOR | HAS_LIPS | HAS_UNDERWEAR | HAS_SKIN_COLOR | HAS_EYE_COLOR

	flesh_color = "#966464"
	base_color = "#B43214"

	//butt_sprite = "vulp"

	cold_level_1 = 200 //Default 260
	cold_level_2 = 140 //Default 200
	cold_level_3 = 80  //Default 120

	heat_level_1 = 330 //Default 360
	heat_level_2 = 380 //Default 400
	heat_level_3 = 800 //Default 1000

	/*
	allowed_consumed_mobs = list(/mob/living/simple_animal/mouse, /mob/living/simple_animal/lizard, /mob/living/simple_animal/chick, /mob/living/simple_animal/chicken,
								 /mob/living/simple_animal/crab, /mob/living/simple_animal/butterfly, /mob/living/simple_animal/parrot, /mob/living/simple_animal/tribble)

	suicide_messages = list(
		"is attempting to bite their tongue off!",
		"is jamming their claws into their eye sockets!",
		"is twisting their own neck!",
		"is holding their breath!")
	*/
	reagent_tag = IS_TAJARA

	heat_discomfort_level = 292
	heat_discomfort_strings = list(
		"Your fur prickles in the heat.",
		"You feel uncomfortably warm.",
		"Your overheated skin itches."
		)
	cold_discomfort_level = 275

/datum/species/vulpkanin/equip_survival_gear(var/mob/living/carbon/human/H)
	..()
	H.equip_to_slot_or_del(new /obj/item/clothing/shoes/sandal(H),slot_shoes)

