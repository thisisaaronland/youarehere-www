<?php

	include("init_local.php");
	loadlib("cli");
	loadlib("mapzen_pelias");

	$spec = array(
		"id" => array("flag" => "i", "required" => 1),
	);
	
	$opts = cli_getopts($spec);

	$rsp = mapzen_pelias_get_info($opts['id']);
	dumper($rsp);

	exit();