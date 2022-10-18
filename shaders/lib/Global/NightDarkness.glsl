
#define NightDarknessLevel 0.8//[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]


    // if (worldTime > TIME) {
	// 	lmcoord.y = lmcoord.y * DARKFACTOR;
	// }
    // DARKFACTOR typically equals a number under 1.0 as 1.0 is default brightness



// get brighter at 22900, end at 23500

float pct;

// Just check the if once instead of going through all else if's constantly
if (worldTime > 23400 || worldTime < 13150) {
	pct = 0.0;
}
else if (worldTime > 23350) {
	pct = 0.0;
}
else if (worldTime > 23300) {
	pct = 0.1;
}
else if (worldTime > 23250) {
	pct = 0.2;
}
else if (worldTime > 23200) {
	pct = 0.3;
}
else if (worldTime > 23150) {
	pct = 0.4;
}
else if (worldTime > 23100) {
	pct = 0.5;
}
else if (worldTime > 23050) {
	pct = 0.6;
}
else if (worldTime > 23000) {
	pct = 0.7;
}
else if (worldTime > 22950) {
	pct = 0.8;
}
else if (worldTime > 22900) {
	pct = 0.9;
}
// sunrise Above, Sunset Below
else if (worldTime > 13600){
	pct = 1.0;
}
else if (worldTime > 13550) {
	pct = 0.9;
}
else if (worldTime > 13500) {
	pct = 0.8;
}
else if (worldTime > 13450) {
	pct = 0.7;
}
else if (worldTime > 13400) {
	pct = 0.6;
}
else if (worldTime > 13350) {
	pct = 0.5;
}
else if (worldTime > 13300) {
	pct = 0.4;
}
else if (worldTime > 13250) {
	pct = 0.3;
}
else if (worldTime > 13200) {
	pct = 0.2;
}
else if (worldTime > 13150) {
	pct = 0.1;
}

lmcoord.y = mix(lmcoord.y, lmcoord.y * NightDarknessLevel, pct);