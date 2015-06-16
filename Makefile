templates:

	php -q ./bin/compile-templates.php

secret:
	php -q ./bin/generate_secret.php

test:
	prove -v --exec 'php' ./tests/*.t

js:
	java -Xmx64m -jar lib/google-compiler/compiler-20100616.jar --js www/javascript/youarehere.js --js www/javascript/youarehere.assertion.js --js www/javascript/youarehere.map.js --js www/javascript/youarehere.woe.js --js www/javascript/youarehere.getlatlon.js > www/javascript/youarehere.min.js	
