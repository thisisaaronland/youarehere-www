<?php

	loadlib("mapzen_pelias");

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

	function api_mapzen_youarehere_decide(){

	}

	########################################################################

	# the end