AE_START_TS := $(shell date +%s)
AE_END_TS := $(shell date +%s --date="1 month")

START_TS := $(shell date +"%Y-%m-%d")
END_TS := $(shell date +"%Y-%m-%d" --date="1 month")

out/allevents.txt:
	curl --silent --cookie-jar /tmp/allevents.cookies https://allevents.in/ -o /dev/null
	curl --silent --cookie /tmp/allevents.cookies --request POST \
	  --url https://allevents.in/api/index.php/categorization/web/v1/list \
	  --header 'Referer: https://allevents.in/bangalore/all' \
	  --header "Content-Type: application/json" \
	  --data-raw '{"venue": 0,"page": 1,"rows": 100,"tag_type": null,"sdate": $(AE_START_TS),"edate": $(AE_END_TS),"city": "bangalore","keywords": 0,"category": ["all"],"formats": 0,"sort_by_score_only": true}' | \
	  jq -r '.item[] | .share_url' | sort > out/allevents.txt

out/atta_galatta.json:
	python src/atta_galatta.py

out/champaca.json:
	python src/champaca.py

out/highape.txt:
	python src/highape.py | sort > out/highape.txt

out/mapindia.json:
	curl --silent --request GET \
	--url 'https://map-india.org/wp-admin/admin-ajax.php?action=WP_FullCalendar&type=event&start=$(START_TS)&end=$(END_TS)' | jq -r '.' > out/mapindia.json

out/bengalurusustainabilityforum.json:
	curl --silent --request GET \
  	--url 'https://www.bengalurusustainabilityforum.org/wp-json/eventin/v1/event/events?month=2099&year=12&start=$(START_TS)&end=$(END_TS)&postParent=child&selectedCats=116%2C117%2C118%2C119%2C120' | jq -r '.' > out/bengalurusustainabilityforum.json

out/bic.ics:
	wget "https://bangaloreinternationalcentre.org/events/?ical=1" -O out/bic.ics

out/insider.txt:
	curl --silent \
	--url 'https://api.insider.in/home?city=bengaluru&eventType=physical&filterBy=go-out&norm=1&select=lite&typeFilter=physical' | \
	jq -r '.list.masterList|keys[]|["https://insider.in",., "event"]|join("/")' | sort > out/insider.txt

out/bhaagoindia.txt:
	python src/bhaagoindia.com.py | sort > out/bhaagoindia.txt

# TODO: /exhibits.json is also helpful
# And there are kn translations available as well.
out/scigalleryblr.json:
	python src/scigallery.py

out/venn.json:
	python src/venn.py

out/mmb.txt:
	python src/mmb.py | sort > out/mmb.txt

out/urbanaut.json:
	python src/urbanaut.py

out/zomato.json:
	python src/zomato.py

out/bic.json:
	python src/ics-to-event.py out/bic.ics  out/bic.json

out/sofar.json:
	python src/sofar.py

all: out/allevents.txt \
 out/highape.txt \
 out/mapindia.json \
 out/bic.ics \
 out/insider.txt \
 out/bengalurusustainabilityforum.json \
 out/bhaagoindia.txt \
 out/scigalleryblr.json \
 out/mmb.txt \
 out/venn.json \
 out/zomato.json \
 out/urbanaut.json \
 out/champaca.json \
 out/atta_galatta.json \
 out/bic.json \
 out/sofar.json
	@echo "Done"

db:
	python src/event-fetcher.py