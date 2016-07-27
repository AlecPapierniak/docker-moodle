Simple (and ugly!) Dockerfile for a Moodle install.

This is based on work done by Serio Gomez. Original repo can be found here: https://github.com/sergiogomez/docker-moodle

Clone this repo, then: 

	docker build -t="moodle-base" .

	docker run --name moodle1 -e VIRTUAL_HOST=moodle.domain.tld -d -p 8081:80 moodle-base /start.sh

The default setup is for a moodle instance running behing a reverse proxy. The reverse proxy handles TLS, so moodle.domain.tld must be HTTPS enabled.
