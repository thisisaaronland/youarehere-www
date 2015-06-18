<?php

	loadlib("mapzen_pelias");
	loadlib("geo_utils");

	########################################################################

	function api_mapzen_youarehere_choose(){

		$q = request_str("query");

		if (! $q){
			api_output_error(400, "Missing query string");
		}

		if (! preg_match("/^([\w\d\s]+)$/", $q)){
			api_output_error(400, "Invalid query string");
		}

		$rsp = mapzen_pelias_geocode($q);

		if (! $rsp['ok']){
			api_output_error(500, $rsp['error']);
		}

		$data = $rsp['data'];
		api_output_ok($data);
	}

	########################################################################

	function api_mapzen_youarehere_nearby(){

		$lat = request_float("latitude");
		$lon = request_float("longitude");

		$lat = (geo_utils_is_valid_latitude($lat)) ? $lat : null;
		$lon = (geo_utils_is_valid_longitude($lon)) ? $lon : null;

		if (! $lat){
			api_output_error(400, "Missing or invalid latitude");
		}

		if (! $lon){
			api_output_error(400, "Missing or invalid longitude");
		}

		# filter / zoom level

		$more = array('layers' => 'admin');
		$rsp = mapzen_pelias_reverse_geocode($lat, $lon);

		if (! $rsp['ok']){
			api_output_error(500, $rsp['error']);
		}

		$data = $rsp['data'];
		api_output_ok($data);		
	}

	########################################################################

	function api_mapzen_youarehere_decide(){

	}

	########################################################################

	# the end