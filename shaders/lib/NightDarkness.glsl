
#define NightDarknessLevel 3//[0 1 2 3 4 5 6]


    // if (worldTime > TIME) {
	// 	lmcoord.y = lmcoord.y * DARKFACTOR;
	// }
    // DARKFACTOR typically equals a number under 1.0 as 1.0 is default brightness



// get brighter at 22900, end at 23500
#if NightDarknessLevel == 6
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    else if (worldTime > 23400) {
		lmcoord.y = lmcoord.y * 0.9;
	}
    else if (worldTime > 23300) {
		lmcoord.y = lmcoord.y * 0.8;
	}
    else if (worldTime > 23200) {
		lmcoord.y = lmcoord.y * 0.7;
	}
    else if (worldTime > 23100) {
		lmcoord.y = lmcoord.y * 0.6;
	}
    else if (worldTime > 23000) {
		lmcoord.y = lmcoord.y * 0.5;
	}
    // sunrise Above, Sunset Below
	else if (worldTime > 13600){
		lmcoord.y = lmcoord.y * 0.4;
	}
	else if (worldTime > 13500) {
		lmcoord.y = lmcoord.y * 0.5;
	}
	else if (worldTime > 13400) {
		lmcoord.y = lmcoord.y * 0.6;
	}
	else if (worldTime > 13300) {
		lmcoord.y = lmcoord.y * 0.7;
	}
	else if (worldTime > 13200) {
		lmcoord.y = lmcoord.y * 0.8;
	}
	else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 5
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    else if (worldTime > 23400) {
		lmcoord.y = lmcoord.y * 0.9;
	}
    else if (worldTime > 23300) {
		lmcoord.y = lmcoord.y * 0.8;
	}
    else if (worldTime > 23200) {
		lmcoord.y = lmcoord.y * 0.7;
	}
    else if (worldTime > 23100) {
		lmcoord.y = lmcoord.y * 0.6;
	}
    // sunrise Above, Sunset Below
	else if (worldTime > 13500) {
		lmcoord.y = lmcoord.y * 0.5;
	}
	else if (worldTime > 13400) {
		lmcoord.y = lmcoord.y * 0.6;
	}
	else if (worldTime > 13300) {
		lmcoord.y = lmcoord.y * 0.7;
	}
	else if (worldTime > 13200) {
		lmcoord.y = lmcoord.y * 0.8;
	}
	else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 4
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    else if (worldTime > 23400) {
		lmcoord.y = lmcoord.y * 0.9;
	}
    else if (worldTime > 23300) {
		lmcoord.y = lmcoord.y * 0.8;
	}
    else if (worldTime > 23200) {
		lmcoord.y = lmcoord.y * 0.7;
	}
    // sunrise Above, Sunset Below
    else if (worldTime > 13400) {
		lmcoord.y = lmcoord.y * 0.6;
	}
	else if (worldTime > 13300) {
		lmcoord.y = lmcoord.y * 0.7;
	}
	else if (worldTime > 13200) {
		lmcoord.y = lmcoord.y * 0.8;
	}
	else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 3
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    else if (worldTime > 23400) {
		lmcoord.y = lmcoord.y * 0.9;
	}
    else if (worldTime > 23300) {
		lmcoord.y = lmcoord.y * 0.8;
	}
    // sunrise Above, Sunset Below
	else if (worldTime > 13300) {
		lmcoord.y = lmcoord.y * 0.7;
	}
	else if (worldTime > 13200) {
		lmcoord.y = lmcoord.y * 0.8;
	}
	else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 2
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    else if (worldTime > 23400) {
		lmcoord.y = lmcoord.y * 0.9;
	}
    // sunrise Above, Sunset Below
	else if (worldTime > 13200) {
		lmcoord.y = lmcoord.y * 0.8;
	}
	else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 1
    if (worldTime > 23500) {
		lmcoord.y = lmcoord.y * 1.0;
	}
    // sunrise Above, Sunset Below
     else if (worldTime > 13100) {
		lmcoord.y = lmcoord.y * 0.9;
	}
#endif

#if NightDarknessLevel == 0
#endif

