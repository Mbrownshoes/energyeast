## Canada 

build/ne_10m_admin_0_map_subunits.shp: build/ne_10m_admin_0_map_subunits.zip
	unzip -od $(dir $@) $<
	touch $@

build/subunits.json: build/ne_10m_admin_0_map_subunits.shp
	ogr2ogr -f GeoJSON -where "ADM0_A3 IN ('CAN')"  \
	build/subunits.json \
	build/ne_10m_admin_0_map_subunits.shp

canada.json: build/subunits.json
	node_modules/.bin/topojson \
		--projection='width = 1060, height = 1100, d3.geo.conicConformal() \
				.rotate([98, 0]) \
			    .center([10, 60]) \
			    .parallels([10, 85.5]) \
			    .scale(1400) \
			    .translate([width / 2, height / 2]) \
			    .precision(.1)' \
		-o $@ \
		-- $<

# ## provinces ##
build/gpr_000b11a_e.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://www12.statcan.gc.ca/census-recensement/2011/geo/bound-limit/files-fichiers/$(notdir $@)

build/gpr_000b11a_e.shp: build/gpr_000b11a_e.zip
	unzip -od $(dir $@) $<
	touch $@



prov.json: build/gpr_000b11a_e.shp 
	node_modules/.bin/topojson \
		-o $@ \
		--projection='width = 960, height = 600, d3.geo.conicConformal() \
			.rotate([98, 0]) \
		    .center([0, 60]) \
		    .parallels([-10, 85.5]) \
		    .scale(1000) \
		    .translate([width / 2, height / 2]) \
		    .precision(.1)' \
		--simplify=.1 \
		--filter=none \
		-- prov=$<