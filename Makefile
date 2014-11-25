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
		--simplify=0.5 \
		-- prov=$<

can.json: build/prov.json
	node_modules/.bin/topojson-merge \
		-o $@ \
		--in-object=prov \
		--out-object=nation \
		-- $<