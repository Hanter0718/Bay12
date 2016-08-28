#if !defined(USING_MAP_DATUM)

	#include "harroway_areas.dm"
	#include "harroway_shuttles.dm"
	#include "harroway_unit_testing.dm"
	#include "harroway_holodecks.dm"

	#include "harroway-1.dmm"
	#include "harroway-2.dmm"
	#include "harroway-3.dmm"
	#include "harroway-4.dmm"
	#include "harroway-5.dmm"
	#include "harroway-6.dmm"

	#define USING_MAP_DATUM /datum/map/harroway

#elif !defined(MAP_OVERRIDE)

	#warn A map has already been included, ignoring Harroway

#endif
