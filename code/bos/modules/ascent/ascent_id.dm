// ID 'card'
/obj/item/card/id/ascent
	name = "alien chip"
	icon = 'icons/bos/obj/ascent.dmi'
	icon_state = "access_card"
	desc = "A slender, complex chip of alien circuitry."
	access = list(access_ascent)

/obj/item/card/id/ascent/gyne
	access = list(access_ascent, access_ascentpar)

/obj/item/card/id/ascenttiro
	name = "tiro chip"
	icon = 'icons/bos/obj/ascent.dmi'
	icon_state = "tiro_card"
	desc = "A slender, complex chip of alien circuitry. This one has been designed for use by humanoids."
	access = list(access_ascent)

/obj/item/card/id/ascent/GetAccess()
	var/mob/living/carbon/human/H = loc
	if(istype(H) && !(H.species.name in list(SPECIES_MANTID_ALATE, SPECIES_MANTID_GYNE, SPECIES_NABBER, SPECIES_MONARCH_QUEEN, SPECIES_MONARCH_WORKER)))
		. = list()
	else
		. = ..()

/obj/item/card/id/ascent/on_update_icon()
	return

/obj/item/card/id/ascent/prevent_tracking()
	return TRUE

/obj/item/card/id/ascent/attack_self(mob/user)
	return

/obj/item/card/id/ascent/show()
	return

// ID implant/organ/interface device.
/obj/item/organ/internal/controller
	name = "system controller"
	desc = "A fist-sized lump of complex circuitry."
	icon = 'icons/bos/obj/ascent.dmi'
	icon_state = "plant"
	parent_organ = BP_CHEST
	organ_tag = BP_SYSTEM_CONTROLLER
	surface_accessible = TRUE
	var/obj/item/card/id/id_card = /obj/item/card/id/ascent

/obj/item/organ/internal/controller/replaced(mob/living/carbon/human/target, obj/item/organ/external/affected)
	. = ..()
	if(owner)
		owner.add_language(LANGUAGE_MANTID_BROADCAST)

/obj/item/organ/internal/controller/removed(mob/living/user, drop_organ, detach)
	var/mob/living/carbon/H = owner
	. = ..()
	if(istype(H) && H != owner && !(locate(type) in H.internal_organs))
		H.remove_language(LANGUAGE_MANTID_BROADCAST)

/obj/item/organ/internal/controller/Initialize()
	if(ispath(id_card))
		id_card = new id_card(src)
	robotize()
	. = ..()
	if(owner)
		owner.set_id_info(id_card)

/obj/item/organ/internal/controller/GetIdCard()
	//Not using is_broken() because it should be able to function when CUT_AWAY is set
	if(damage < min_broken_damage)
		return id_card

/obj/item/organ/internal/controller/GetAccess()
	if(id_card && damage < min_broken_damage)
		return id_card.GetAccess()

/obj/item/organ/internal/controller/tiro
	name = "tiro identification stack"
	desc = "A complex lump of circuitry which connects a Humanoid with the Ascent's neural network. Feels faintly warm."
	icon_state = "tiroplant"
	id_card = /obj/item/card/id/ascenttiro
