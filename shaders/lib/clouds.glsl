        
        // To form the planes that the clouds are generated between. One is start pos one is end pos.
        // raymarch between them using the lower one as the start pos and the higher one as endpos

    // vec3 bs     = scenevec*((cloud_minAlt-eyeAltitude)/scenevec.y);
    // vec3 ts     = scenevec*((cloud_maxAlt-eyeAltitude)/scenevec.y);

        // Raymarching is, have a rayposition variable that is you startpos, then you add a incremental position value to it 
            // with every loop iteration and sample the stuff you need with each step eg cloud shape, lighting or whatever
            // the increment is usually (endpos-startpos)/steps

    // Raymarch example

    // vec3 startpos = vec3(blah);
    // vec3 endpos = vec3(blah);
    // vec3 increment = (endpos-startpos)/steps;
    // vec3 raypos = cameraPosition + startpos;

    // for (int i<steps; raypos += increment) {
    // code stuff
    // }