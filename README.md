Simple (and ugly!) Dockerfile for a Moodle install.

Clone this repo, then: 

	docker build -t="moodle-base" .

	docker run --name moodle1 -e VIRTUAL_HOST=moodle.domain.tld -d -p 8081:80 moodle-base /start.sh

The default setup is for a moodle instance running behing a reverse proxy. The reverse proxy handles TLS, so moodle.domain.tld must be HTTPS enabled.
