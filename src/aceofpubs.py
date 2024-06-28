import sys
import datetime
import json
from common import icalendar
from common.tz import IST


def fix_date(date_str):
    d = datetime.datetime.fromisoformat(date_str)
    d.replace(tzinfo=IST)
    return d.isoformat()


def modify_event(event):
    event["keywords"] = [x.strip() for x in event["keywords"][0].split(",")]
    event["name"] = event["name"].split("|")[0].strip()
    if event["description"] == "":
        event["description"] = "A Pub hosted by Ace of Pubs"
    event["startDate"] = fix_date(event["startDate"])
    event["endDate"] = fix_date(event["endDate"])
    event["keywords"] = ["QUIZ"]
    # TODO: Make this into a Place
    event["location"] = event["location"]["name"]
    return event


if __name__ == "__main__":
    input_ics_file = "out/aceofpubs.ics"
    output_json_file = "out/aceofpubs.json"

    json_data = icalendar.convert_ics_to_events(input_ics_file)
    json_data = [
        modify_event(event)
        for event in json_data
        if (
            "bangalore" in event["location"]["name"].lower()
            or "bengaluru" in event["location"]["name"].lower()
        )
    ]

    with open(output_json_file, "w") as output_file:
        output_file.write(json.dumps(json_data, indent=2))

    print(f"JSON data saved to {output_json_file}")
