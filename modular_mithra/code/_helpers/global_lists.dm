GLOBAL_LIST_EMPTY(weavable_structures)
GLOBAL_LIST_EMPTY(weavable_items)

/hook/startup/proc/init_mirthacustom_datum_ref_lists()
	var/paths

	// Weaver recipe stuff
	paths = subtypesof(/datum/weaver_recipe/structure)
	for(var/path in paths)
		var/datum/weaver_recipe/instance = new path()
		if(!instance.title)
			continue //A prototype or something
		GLOB.weavable_structures[instance.title] = instance

	paths = subtypesof(/datum/weaver_recipe/item)
	for(var/path in paths)
		var/datum/weaver_recipe/instance = new path()
		if(!instance.title)
			continue //A prototype or something
		GLOB.weavable_items[instance.title] = instance

	return 1 // Hooks must return 1
