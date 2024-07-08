import yaml
import json
from common.session import get_cached_session

IGNORED_URL_SLUGS = [
    "delhi",
    "mumbai",
    "pune",
]


def get_event_urls(org_id):
    session = get_cached_session()
    response = session.get(
        f"https://www.townscript.com/listings/event/upcoming/userId/{org_id}"
    )
    d = response.json()
    for e in d["data"]:
        yield f"https://www.townscript.com/e/{e['shortName']}"


def main():
    config = yaml.safe_load(open("in/known-hosts.yml"))["townscript"]
    for c in config:
        for e in get_event_urls(config[c]["id"]):
            ignored = any(slug in e for slug in IGNORED_URL_SLUGS)
            if ignored == False:
                print(e)


if __name__ == "__main__":
    main()
