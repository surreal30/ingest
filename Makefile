AE_START_TS := $(shell date +%s)
AE_END_TS := $(shell date +%s --date="1 month")

START_TS := $(shell date +"%Y-%m-%d")
END_TS := $(shell date +"%Y-%m-%d" --date="1 month")

define restore-file
	(echo "FAIL $1" && git checkout -- $1 && echo "RESTORED $1")
endef

out/allevents.txt:
	curl_chrome116 --silent --cookie-jar /tmp/allevents.cookies https://allevents.in/ -o /dev/null
	curl_chrome116 --silent --cookie /tmp/allevents.cookies --request POST \
	  --url https://allevents.in/api/index.php/categorization/web/v1/list \
	  --header 'Referer: https://allevents.in/bangalore/all' \
	  --header "Content-Type: application/json" \
	  --data-raw '{"venue": 0,"page": 1,"rows": 100,"tag_type": null,"sdate": $(AE_START_TS),"edate": $(AE_END_TS),"city": "bangalore","keywords": 0,"category": ["all"],"formats": 0,"sort_by_score_only": true}' | \
	  jq -r '.item[] | .share_url' | sort > out/allevents.txt || $(call restore-file,$@)

out/skillboxes.txt:
	python src/skillboxes.py | sort > out/skillboxes.txt || $(call restore-file,$@)

out/atta_galatta.json:
	python src/atta_galatta.py || $(call restore-file,$@)

out/champaca.json:
	python src/champaca.py || $(call restore-file,$@)

out/highape.txt:
	python src/highape.py | sort > out/highape.txt || $(call restore-file,$@)

out/mapindia.ics:
	python src/mapindia.py || $(call restore-file,$@)

out/mapindia.json: out/mapindia.ics	
	python src/ics-to-event.py out/mapindia.ics out/mapindia.json || $(call restore-file,$@)

out/bengalurusustainabilityforum.json:
	curl_chrome116 --silent --request GET \
  	--url 'https://www.bengalurusustainabilityforum.org/wp-json/eventin/v1/event/events?month=2099&year=12&start=$(START_TS)&end=$(END_TS)&postParent=child&selectedCats=116%2C117%2C118%2C119%2C120' | jq -r '.' > out/bengalurusustainabilityforum.json \
  	 || $(call restore-file,$@)

out/bic.ics:
	curl_chrome116 --silent "https://bangaloreinternationalcentre.org/events/?ical=1" --output out/bic.ics  || $(call restore-file,$@)

out/insider.txt:
	curl_chrome116 --silent \
	--url 'https://api.insider.in/home?city=bengaluru&eventType=physical&filterBy=go-out&norm=1&select=lite&typeFilter=physical' | \
	jq -r '.list.masterList|keys[]|["https://insider.in",., "event"]|join("/")' | sort > out/insider.txt ||  $(call restore-file,$@)

out/bhaagoindia.txt:
	python src/bhaagoindia.com.py | sort > out/bhaagoindia.txt ||  $(call restore-file,$@)

# TODO: /exhibits.json is also helpful
# And there are kn translations available as well.
out/scigalleryblr.json:
	python src/scigallery.py || $(call restore-file,$@)

out/venn.json:
	python src/venn.py || $(call restore-file,$@)

out/mmb.txt:
	python src/mmb.py | sort > out/mmb.txt || $(call restore-file,$@)

out/urbanaut.json:
	python src/urbanaut.py  || $(call restore-file,$@)

out/zomato.json:
	python src/zomato.py || $(call restore-file,$@)

out/bic.json:
	python src/ics-to-event.py out/bic.ics out/bic.json || $(call restore-file,$@)

out/sofar.json:
	python src/sofar.py || $(call restore-file,$@)

out/sumukha.json:
	python src/sumukha.py || $(call restore-file,$@)

out/townscript.txt:
	python src/townscript.py | sort > out/townscript.txt || $(call restore-file,$@)

out/bluetokai.json:
	python src/bluetokai.py || $(call restore-file,$@)

out/gullytours.json:
	python src/gullytours.py || $(call restore-file,$@)

out/tonight.json:
	python src/tonight.py || $(call restore-file,$@)

out/creativemornings.txt:
	python src/creativemornings.py | sort > out/creativemornings.txt || $(call restore-file,$@)

out/together-buzz.txt:
	python src/together-buzz.py | sort > out/together-buzz.txt || $(call restore-file,$@)

out/adidas.json:
	python src/adidas.py || $(call restore-file,$@)

out/pvr/cinemas.json:
	python src/pvr.py || $(call restore-file,$@)

out/trove.json:
	python src/trove.py || $(call restore-file,$@)

# aceofpubs website is down right now
out/aceofpubs.ics:
	$(call restore-file,$@)
# 	curl_chrome116 "https://aceofpubs.com/events/category/bengaluru-pub-quiz-event/?post_type=tribe_events&ical=1&eventDisplay=list&ical=1" --output "out/aceofpubs.ics"

out/aceofpubs.json: out/aceofpubs.ics
	python src/aceofpubs.py || $(call restore-file,$@)

out/koota.txt:
	curl_chrome116 --silent "https://courtyardkoota.com/event-directory/" | grep -oE 'https://courtyardkoota\.com/events/[a-z0-9-]+/' | sort -u > out/koota.txt || $(call restore-file,$@)

# TODO
# out/sis.txt:
# 	python src/sis.py | sort > out/sis.txt

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
 out/bic.json \
 out/sumukha.json \
 out/sofar.json \
 out/bluetokai.json \
 out/gullytours.json \
 out/townscript.txt \
 out/together-buzz.txt \
 out/skillboxes.txt \
 out/tonight.json \
 out/creativemornings.txt \
 out/adidas.json \
 out/pvr/cinemas.json \
 out/trove.json \
 out/aceofpubs.json \
 out/atta_galatta.json \
 out/koota.txt
	@echo "Done"

db:
	python src/event-fetcher.py