<?php

	########################################################################

	$GLOBALS['mapzen_pelias_host'] = 'https://pelias.mapzen.com/';

	########################################################################

	function mapzen_pelias_reverse_geocode($lat, $lon){

		$query = array('lat' => $lat, 'lon' => $lon);
		$query = http_build_query($query);
		
		$url = "${GLOBALS['mapzen_pelias_host']}reverse?{$query}";

		$rsp = http_get($url);

		if (! $rsp['ok']){
			return $rsp;
		}

		$body = $rsp['body'];
		$data = json_decode($body, "as hash");

		if (! $data){
			return array('ok' => 0, 'error' => 'failed to parse JSON');
		}

		$rsp['data'] = $data;
		return $rsp;
	}

	########################################################################

	# the end

