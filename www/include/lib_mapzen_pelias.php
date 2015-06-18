<?php

	# http://pelias.mapzen.com/

	########################################################################

	$GLOBALS['mapzen_pelias_host'] = 'https://pelias.mapzen.com/';

	########################################################################

	function mapzen_pelias_geocode($q, $more=array()){

		$defaults = array(
			  'coarse' => 0,
		);

		$more = array_merge($defaults, $more);

		$method = ($more['coarse']) ? 'search/coarse/' : 'search/';

		$query = array('input' => $q);
		$query = http_build_query($query);
		
		$url = "${GLOBALS['mapzen_pelias_host']}{$method}?{$query}";
		$rsp = http_get($url);

		return mapzen_pelias_parse_rsp($rsp);
	}

	########################################################################

	function mapzen_pelias_reverse_geocode($lat, $lon, $more=array()){

		$query = array('lat' => $lat, 'lon' => $lon);

		$query = array_merge($more, $query);
		$query = http_build_query($query);
		
		$url = "${GLOBALS['mapzen_pelias_host']}reverse?{$query}";
		$rsp = http_get($url);

		return mapzen_pelias_parse_rsp($rsp);
	}

	########################################################################

	function mapzen_pelias_get_info($id){

		$query = array('id' => $id);
		$query = http_build_query($query);
		
		$url = "${GLOBALS['mapzen_pelias_host']}doc?{$query}";
		$rsp = http_get($url);

		return mapzen_pelias_parse_rsp($rsp);
	}

	########################################################################

	function mapzen_pelias_parse_rsp($rsp){

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

