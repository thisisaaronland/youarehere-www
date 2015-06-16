<?php

	include("init_local.php");
	loadlib("mapzen_pelias");

	$lat = 40.743582;
	$lon = -73.990473;

	$rsp = mapzen_pelias_reverse_geocode($lat, $lon);
	dumper($rsp);

	exit();
?>