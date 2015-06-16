<?php

	include("include/init.php");
	features_ensure_enabled("geocoder");

	loadlib("mapzen_pelias");

	$q = get_str("q");

	if (($q) && (preg_match("/^([\w\d\s]+)$/", $q, $m))){

		$rsp = mapzen_pelias_geocode($m[1]);
		# dumper($rsp['data']);

		if ($rsp['ok']){
			$data = $rsp['data'];
			$GLOBALS['smarty']->assign_by_ref("geojson", $data);
		}
	}

	$GLOBALS['smarty']->display("page_choose.txt");
	exit();
?>
