/proc/isloyal(A) //Checks to see if the person contains a mindshield implant, then checks that the implant is actually inside of them
	for(var/obj/item/weapon/implant/loyalty/L in A)
		if(L && L.implanted)
			return 1
	return 0

/mob/living/carbon/proc/update_handcuffed()
	if(handcuffed)
		drop_r_hand()
		drop_l_hand()
		stop_pulling()
		//throw_alert("handcuffed", /obj/screen/alert/restrained/handcuffed, new_master = src.handcuffed)
	else
		//clear_alert("handcuffed")
	//update_action_buttons_icon() //some of our action buttons might be unusable when we're handcuffed.
	//update_inv_handcuffed()
	//update_hud_handcuffed()
/mob/living/carbon/proc/uncuff()
	if (handcuffed)
		var/obj/item/weapon/W = handcuffed
		handcuffed = null
		//if (buckled && buckled.buckle_requires_restraints)
		//	buckled.unbuckle_mob(src)
		//update_handcuffed()
		if (client)
			client.screen -= W
		if (W)
			W.loc = loc
			W.dropped(src)
			if (W)
				W.layer = initial(W.layer)
	if (legcuffed)
		var/obj/item/weapon/W = legcuffed
		legcuffed = null
		update_inv_legcuffed()
		if (client)
			client.screen -= W
		if (W)
			W.loc = loc
			W.dropped(src)
			if (W)
				W.layer = initial(W.layer)

/obj/item/weapon/implant/proc/implant(mob/target)
/obj/item/weapon/implant/proc/removed(mob/target)

//IMPLANT REMOVE
/*
/datum/surgery/implant_removal
	name = "implant removal"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/extract_implant, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list("chest")
	requires_organic_bodypart = 0


/datum/surgery_step/extract_implant
	name = "extract implant"
	implements = list(/obj/item/weapon/hemostat = 100, /obj/item/weapon/crowbar = 65)
	time = 64
	var/obj/item/weapon/implant/I = null

/datum/surgery_step/extract_implant/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	I = locate(/obj/item/weapon/implant) in target
	if(I)
		user.visible_message("[user] begins to extract [I] from [target]'s [target_zone].", "<span class='notice'>You begin to extract [I] from [target]'s [target_zone]...</span>")
	else
		user.visible_message("[user] looks for an implant in [target]'s [target_zone].", "<span class='notice'>You look for an implant in [target]'s [target_zone]...</span>")

/datum/surgery_step/extract_implant/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(I)
		user.visible_message("[user] successfully removes [I] from [target]'s [target_zone]!", "<span class='notice'>You successfully remove [I] from [target]'s [target_zone].</span>")
		I.removed(target)

		var/obj/item/weapon/implantcase/case

		if(istype(user.get_item_by_slot(slot_l_hand), /obj/item/weapon/implantcase))
			case = user.get_item_by_slot(slot_l_hand)
		else if(istype(user.get_item_by_slot(slot_r_hand), /obj/item/weapon/implantcase))
			case = user.get_item_by_slot(slot_r_hand)
		else
			case = locate(/obj/item/weapon/implantcase) in get_turf(target)

		if(case && !case.imp)
			case.imp = I
			I.loc = case
			case.update_icon()
			user.visible_message("[user] places [I] into [case]!", "<span class='notice'>You place [I] into [case].</span>")
		else
			qdel(I)

	else
		user << "<span class='warning'>You can't find anything in [target]'s [target_zone]!</span>"
	return 1
*/
/obj/item/weapon/implant
	var/activated = 1
	var/allow_multiple = 0
	var/uses = -1

//ANTILOYALITY TG
/obj/item/weapon/implant/antiloyalty
	name = "anti-loyalty implant"
	desc = "Makes you mind more free from NT."
	origin_tech = "materials=2;biotech=4;programming=4;syndicate=2"
	activated = 0

/obj/item/weapon/implant/antiloyalty/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Anti-NTLoyalty <BR>
				<b>Life:</b> over 9000 days.<BR>
				<b>Important Notes:</b> FUCK THE NT!<BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a small pod of nanobots that manipulate the host's mental functions.<BR>
				<b>Special Features:</b> Will prevent and cure most forms of NANOTRASEN brainwashing.<BR>
				<b>Integrity:</b> Implant will last so long as the nanobots are inside the bloodstream."}
	return dat


/obj/item/weapon/implant/antiloyalty/implant(mob/target)
	if(..())
		if(isloyal(target))
			target.visible_message("<span class='warning'>[target] seems to resist the implant!</span>", "<span class='warning'>Вы ненадолго чувствуете свободу от НТ и очень сильную боль в голове!</span>")
			imp_in = null
			qdel(src)
			return -1

		target << "<span class='notice'>You feel a surge of freedom from NT.</span>"
		return 1
	return 0

/obj/item/weapon/implant/antiloyalty/removed(mob/target)
	if(..())
		if(target.stat != DEAD)
			target << "<span class='boldnotice'>Вы чувствуете что-то странное св&#255;занное с НТ</span>"
		return 1
	return 0

/obj/item/weapon/implanter/antiloyalty
	name = "implanter (anti-loyalty)"

/obj/item/weapon/implanter/antiloyalty/New()
	imp = new /obj/item/weapon/implant/antiloyalty(src)
	..()
	update_icon()

/obj/item/weapon/implantcase/antiloyalty
	name = "glass case- 'Anti-NTLoyalty'"
	desc = "A case containing a \"FUCK THE NT\" implant."
	icon = 'icons/obj/items.dmi'
	icon_state = "implantcase-r"

/obj/item/weapon/implantcase/antiloyalty/New()
	imp = new /obj/item/weapon/implant/antiloyalty(src)
	..()


//FREEDOM TG
/obj/item/weapon/implant/freedom
	name = "freedom implant"
	desc = "Use this to escape from those evil Red Shirts."
	icon_state = "freedom"
	implant_color = "r"
	origin_tech = "combat=5;magnets=3;biotech=4;syndicate=2"
	uses = 4


/obj/item/weapon/implant/freedom/activate()
	uses--
	imp_in << "You feel a faint click."
	if(iscarbon(imp_in))
		var/mob/living/carbon/C_imp_in = imp_in
		C_imp_in.uncuff()
	if(!uses)
		qdel(src)


/obj/item/weapon/implant/freedom/get_data()
	var/dat = {"
<b>Implant Specifications:</b><BR>
<b>Name:</b> Freedom Beacon<BR>
<b>Life:</b> optimum 5 uses<BR>
<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
<HR>
<b>Implant Details:</b> <BR>
<b>Function:</b> Transmits a specialized cluster of signals to override handcuff locking
mechanisms<BR>
<b>Special Features:</b><BR>
<i>Neuro-Scan</i>- Analyzes certain shadow signals in the nervous system<BR>
<HR>
No Implant Specifics"}
	return dat


/obj/item/weapon/implanter/freedom
	name = "implanter (freedom)"

/obj/item/weapon/implanter/freedom/New()
	imp = new /obj/item/weapon/implant/freedom(src)
	..()


/obj/item/weapon/implantcase/freedom
	name = "implant case - 'Freedom'"
	desc = "A glass case containing a freedom implant."

/obj/item/weapon/implantcase/freedom/New()
	imp = new /obj/item/weapon/implant/freedom(src)
	..()

//KRAV MAGA TG
/*
/obj/item/weapon/implant/krav_maga
	name = "krav maga implant"
	desc = "Teaches you the arts of Krav Maga in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	activated = 1
	origin_tech = "materials=2;biotech=4;combat=5;syndicate=4"
	var/datum/martial_art/krav_maga/style = null

/obj/item/weapon/implant/krav_maga/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Krav Maga Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Teaches even the clumsiest host the arts of Krav Maga."}
	return dat

/obj/item/weapon/implant/krav_maga/activate()
	var/mob/living/carbon/human/H = imp_in
	if(!ishuman(H))
		return
	if(istype(H.martial_art, /datum/martial_art/krav_maga))
		style.remove(H)
	else
		style.teach(H,1)

/obj/item/weapon/implanter/krav_maga
	name = "implanter (krav maga)"

/obj/item/weapon/implanter/krav_maga/New()
	imp = new /obj/item/weapon/implant/krav_maga(src)
	style = new
	..()

/obj/item/weapon/implantcase/krav_maga
	name = "implant case - 'Krav Maga'"
	desc = "A glass case containing an implant that can teach the user the arts of Krav Maga."

/obj/item/weapon/implantcase/krav_maga/New()
	imp = new /obj/item/weapon/implant/krav_maga(src)
	..()
*/

/obj/item/weapon/implant/weapons_auth
	name = "firearms authentication implant"
	desc = "Lets you shoot your guns"
	icon_state = "auth"
	origin_tech = "magnets=2;programming=7;biotech=5;syndicate=5"
	activated = 0

/obj/item/weapon/implant/weapons_auth/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Firearms Authentication Implant<BR>
				<b>Life:</b> 4 hours after death of host<BR>
				<b>Implant Details:</b> <BR>
				<b>Function:</b> Allows operation of implant-locked weaponry, preventing equipment from falling into enemy hands."}
	return dat



/obj/item/weapon/implant/emp
	name = "emp implant"
	desc = "Triggers an EMP."
	icon_state = "emp"
	origin_tech = "biotech=3;magnets=4;syndicate=1"
	uses = 3

/obj/item/weapon/implant/emp/activate()
	uses--
	empulse(imp_in, 3, 5)
	if(!uses)
		qdel(src)



/obj/item/weapon/storage/internal/implant
	name = "bluespace pocket"
	max_w_class = 3
	//max_w_class = 6
	cant_hold = list(/obj/item/weapon/disk/nuclear)
	//silent = 1
	use_sound = null

/obj/item/weapon/implant/storage
	name = "storage implant"
	desc = "Stores up to two big items in a bluespace pocket."
	icon_state = "storage"
	origin_tech = "materials=2;magnets=4;bluespace=5;syndicate=4"
	implant_color = "r"
	var/obj/item/weapon/storage/internal/implant/storage

/obj/item/weapon/implant/storage/New()
	..()
	storage = new /obj/item/weapon/storage/internal/implant(src)

/obj/item/weapon/implant/storage/activate()
	storage.MouseDrop(imp_in)

/obj/item/weapon/implant/storage/removed(source)
	if(..())
		storage.close_all()
		for(var/obj/item/I in storage)
			storage.remove_from_storage(I, get_turf(source))
		return 1

/obj/item/weapon/implant/storage/implant(mob/source)
	var/obj/item/weapon/implant/storage/imp_e = locate(src.type) in source
	if(imp_e)
		imp_e.storage.storage_slots += storage.storage_slots
		imp_e.storage.max_w_class += storage.max_w_class
		imp_e.storage.contents += storage.contents

		storage.close_all()
		storage.show_to(source)

		qdel(src)
		return 1

	return ..()

/obj/item/weapon/implanter/storage
	name = "implanter (storage)"

/obj/item/weapon/implanter/storage/New()
	imp = new /obj/item/weapon/implant/storage(src)
	..()

