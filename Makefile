# nation and provinces 

build/gpr_000b11a_e.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/$(notdir $@)

build/gpr_000b11a_e.shp: build/gpr_000b11a_e.zip
	unzip -od $(dir $@) $<
	touch $@


build/prov.json: build/gpr_000b11a_e.shp 
	node_modules/.bin/topojson \
		-o $@ \
		--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
	    --properties='province=PRENAME' \
		--simplify=0.5 \
		-- prov=$<

can.json: build/prov.json
	node_modules/.bin/topojson-merge \
		-o $@ \
		--in-object=prov \
		--out-object=nation \
		-- $<

# Gov pipeline data

build/pipe.json: build/can/EN_1180009_1.shp
	ogr2ogr -f GeoJSON -where "PRODUCT = 1 OR PRODUCT = 2" \
	build/pipe.json \
	build/can/EN_1180009_1.shp

pipeline.json: build/pipe.json
	node_modules/.bin/topojson \
	--o $@ \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
	--properties=PRODUCT,CODE \
	-- pipeline=$<

# entire energy east as one
energyEast.json: build/mygeodata/energy_east.shp
	node_modules/.bin/topojson \
	--o $@ \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
	-- pipeline=$<

# existing pipelin
existing_pipeline.json: build/existing/energy_east.shp
	node_modules/.bin/topojson \
	--o $@ \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
	-- pipeline=$<

# new pipeline
new_pipeline.json: build/newpipe/alberta.shp
	node_modules/.bin/topojson \
	--o $@ \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
	-- pipeline=$<

# First Nations lands
# merge provinces
AL_TA_Alberta_2_55_eng.json: build/al_ta_ab_shp_eng/AL_TA_AB_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_Alberta_2_55_eng.json -- province=build/al_ta_ab_shp_eng/AL_TA_AB_2_55_eng.shp 

AL_TA_Manitoba_2_55_eng.json: build/al_ta_mb_shp_eng/AL_TA_MB_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_Manitoba_2_55_eng.json -- province=build/al_ta_mb_shp_eng/AL_TA_MB_2_55_eng.shp 

AL_TA_Ontario_2_55_eng.json: build/al_ta_on_shp_eng/AL_TA_ON_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_Ontario_2_55_eng.json -- province=build/al_ta_on_shp_eng/AL_TA_ON_2_55_eng.shp 

AL_TA_Quebec_2_55_eng.json: build/al_ta_qc_shp_eng/AL_TA_QC_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_Quebec_2_55_eng.json -- province=build/al_ta_qc_shp_eng/AL_TA_QC_2_55_eng.shp 

AL_TA_Saskatchewan_2_55_eng.json: build/al_ta_sk_shp_eng/AL_TA_SK_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_Saskatchewan_2_55_eng.json -- province=build/al_ta_sk_shp_eng/AL_TA_SK_2_55_eng.shp 

AL_TA_New_Brunswick2_55_eng.json: build/al_ta_nb_shp_eng/AL_TA_NB_2_55_eng.shp 
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1300) \
		    .translate([width / 2, height / 2])' \
    --simplify=0.1 \
	--o AL_TA_New_Brunswick_2_55_eng.json -- province=build/al_ta_nb_shp_eng/AL_TA_NB_2_55_eng.shp 


#populated places

build/cities.json: build/ne_10m_populated_places/ne_10m_populated_places.shp
	ogr2ogr -f GeoJSON -where "ISO_A2 = 'CA' AND SCALERANK < 8"  \
	build/cities.json \
	build/ne_10m_populated_places/ne_10m_populated_places.shp

cities.json: build/cities.json
	node_modules/.bin/topojson \
	--projection='width = 960, height = 800, d3.geo.conicConformal() \
		.rotate([98, 0]) \
	    .center([0, 60]) \
	    .parallels([-10, 85.5]) \
	    .scale(1300) \
	    .translate([width / 2, height / 2])' \
    --properties='province=ADM1NAME',POP_MAX,'name=NAME' \
	-o $@ \
	-- $<
