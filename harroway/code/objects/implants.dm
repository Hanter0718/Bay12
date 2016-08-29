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
		target.mind.readd_antag_light()
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

//CHEM TG
/obj/item/weapon/implant/chem
	name = "chem implant"
	desc = "Injects things."
	icon_state = "reagents"
	origin_tech = "materials=3;biotech=4"
	flags = OPENCONTAINER

/obj/item/weapon/implant/chem/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Robust Corp MJ-420 Prisoner Management Implant<BR>
				<b>Life:</b> Deactivates upon death but remains within the body.<BR>
				<b>Important Notes: Due to the system functioning off of nutrients in the implanted subject's body, the subject<BR>
				will suffer from an increased appetite.</B><BR>
				<HR>
				<b>Implant Details:</b><BR>
				<b>Function:</b> Contains a small capsule that can contain various chemicals. Upon receiving a specially encoded signal<BR>
				the implant releases the chemicals directly into the blood stream.<BR>
				<b>Special Features:</b>
				<i>Micro-Capsule</i>- Can be loaded with any sort of chemical agent via the common syringe and can hold 50 units.<BR>
				Can only be loaded while still in its original case.<BR>
				<b>Integrity:</b> Implant will last so long as the subject is alive."}
	return dat

/obj/item/weapon/implant/chem/New()
	..()
	create_reagents(50)
	tracked_implants += src

/obj/item/weapon/implant/chem/Destroy()
	..()
	tracked_implants -= src




/obj/item/weapon/implant/chem/trigger(emote, mob/source)
	if(emote == "deathgasp")
		activate(reagents.total_volume)

/obj/item/weapon/implant/chem/activate(cause)
	if(!cause || !imp_in)
		return 0
	var/mob/living/carbon/R = imp_in
	var/injectamount = null
	if (cause == "action_button")
		injectamount = reagents.total_volume
	else
		injectamount = cause
	reagents.trans_to(R, injectamount)
	R << "<span class='italics'>You hear a faint beep.</span>"
	if(!reagents.total_volume)
		R << "<span class='italics'>You hear a faint click from your chest.</span>"
		qdel(src)


/obj/item/weapon/implantcase/chem
	name = "implant case - 'Remote Chemical'"
	desc = "A glass case containing a remote chemical implant."

/obj/item/weapon/implantcase/chem/New()
	imp = new /obj/item/weapon/implant/chem(src)
	..()

/obj/item/weapon/implantcase/chem/attackby(obj/item/weapon/W, mob/user, params)
	if(imp)
		imp.attackby(W, user, params)
	else
		return ..()

//FREEDOM TG
/obj/item/weapon/implant/freedom
	name = "freedom implant"
	desc = "Use this to escape from those evil Red Shirts."
	icon_state = "freedom"
	item_color = "r"
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
/obj/item/weapon/implant/krav_maga
	name = "krav maga implant"
	desc = "Teaches you the arts of Krav Maga in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"
	activated = 1
	origin_tech = "materials=2;biotech=4;combat=5;syndicate=4"
	var/datum/martial_art/krav_maga/style = new

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
	..()

/obj/item/weapon/implantcase/krav_maga
	name = "implant case - 'Krav Maga'"
	desc = "A glass case containing an implant that can teach the user the arts of Krav Maga."

/obj/item/weapon/implantcase/krav_maga/New()
	imp = new /obj/item/weapon/implant/krav_maga(src)
	..()


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


/obj/item/weapon/implant/adrenalin
	name = "adrenal implant"
	desc = "Removes all stuns and knockdowns."
	icon_state = "adrenal"
	origin_tech = "materials=2;biotech=4;combat=3;syndicate=4"
	uses = 3

/obj/item/weapon/implant/adrenalin/get_data()
	var/dat = {"<b>Implant Specifications:</b><BR>
				<b>Name:</b> Cybersun Industries Adrenaline Implant<BR>
				<b>Life:</b> Five days.<BR>
				<b>Important Notes:</b> <font color='red'>Illegal</font><BR>
				<HR>
				<b>Implant Details:</b> Subjects injected with implant can activate an injection of medical cocktails.<BR>
				<b>Function:</b> Removes stuns, increases speed, and has a mild healing effect.<BR>
				<b>Integrity:</b> Implant can only be used three times before reserves are depleted."}
	return dat

/obj/item/weapon/implant/adrenalin/activate()
	uses--
	imp_in << "<span class='notice'>You feel a sudden surge of energy!</span>"
	imp_in.SetStunned(0)
	imp_in.SetWeakened(0)
	imp_in.SetParalysis(0)
	imp_in.adjustStaminaLoss(-75)
	imp_in.lying = 0
	imp_in.update_canmove()

	imp_in.reagents.add_reagent("synaptizine", 10)
	imp_in.reagents.add_reagent("omnizine", 10)
	imp_in.reagents.add_reagent("stimulants", 10)
	if(!uses)
		qdel(src)


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




/obj/item/weapon/implant/storage
	name = "storage implant"
	desc = "Stores up to two big items in a bluespace pocket."
	icon_state = "storage"
	origin_tech = "materials=2;magnets=4;bluespace=5;syndicate=4"
	item_color = "r"
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
		imp_e.storage.max_combined_w_class += storage.max_combined_w_class
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

