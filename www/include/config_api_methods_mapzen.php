<?php

	########################################################################

	$GLOBALS['cfg']['api']['methods'] = array_merge(array(

		"mapzen.youarehere.choose" => array (
			"description" => "",
			"documented" => 1,
			"enabled" => 1,
			"library" => "api_mapzen_youarehere",
			"requires_perms" => 0,
			"parameters" => array(
				array(
				      "name" => "query",
				      "required" => 1,
				      "documented" => 1,
				      )
			),
		),

		"mapzen.youarehere.decide" => array(
			"description" => "",
			"documented" => 0,
			"enabled" => 1,
			"library" => "api_mapzen_youarehere",
			"requires_perms" => 2,
			"requires_method" => "POST",
		),

	), $GLOBALS['cfg']['api']['methods']);

	########################################################################

	# the end
