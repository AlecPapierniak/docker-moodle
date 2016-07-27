docker build -t="moodle-base" .

docker run --name moodle1 -e VIRTUAL_HOST=moodle.domain.tld -ti -p 8081:80 moodle-base /bin/bash