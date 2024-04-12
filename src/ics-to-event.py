import sys
import ics
import json
import re

LANGUAGE_MAP = {
    "Hindi": "hi",
    "Kannada": "kn",
    "Tamil": "ta",
    "Telugu": "te",
    "Malayalam": "ml",
    "Marathi": "mr",
    "Bengali": "bn",
    "Gujarati": "gu",
    "Punjabi": "pa",
    "Odia": "or",
    "Assamese": "as",
    "Urdu": "ur",
    "Sanskrit": "sa",
    "Nepali": "ne",
    "Sindhi": "sd"
}

def convert_ics_to_json(ics_file_path):
    """
    Convert ICS calendar file to JSON-LD containing schema.org events.

    Args:
        ics_file_path (str): Path to the ICS file.

    Returns:
        str: JSON-LD string containing schema.org events.
    """
    events = []

    with open(ics_file_path, 'r') as file:
        calendar = ics.Calendar(file.read())

    for event in calendar.events:
        event_json = {
            "@context": "http://schema.org",
            "@type": "Event",
            "name": event.name,
            "startDate": event.begin.isoformat(),
            "endDate": event.end.isoformat(),
            "description": event.description,
            "location": {
                "@type": "Place",
                "name": event.location
            },
            "url": event.url,
            "keywords": ", ".join(sorted(event.categories)),
        }

        for l in LANGUAGE_MAP:
            regex = r"\b" + l + r"\b"
            if re.search(regex, event_json['description']):
                event_json['inLanguage'] = LANGUAGE_MAP[l]

        if 'inLanguage' not in event_json:
            event_json['inLanguage'] = "en"

        if re.search(r"\bsubtitles", event_json['description'], re.IGNORECASE):
            event_json['@type'] = "ScreeningEvent"
            event_json['workPresented'] = {
                "@type": "Movie",
                "name": event.name,
            }
            
            L_WITH_ENGLISH = LANGUAGE_MAP  | {"English": "en"}
            for l in L_WITH_ENGLISH:
                if re.search(r"\b" + l + r" subtitles\b", event_json['description'], re.IGNORECASE):
                    event_json['subtitleLanguage'] = L_WITH_ENGLISH[l]

        if 'Performing Arts' in event.categories and 'Theatre' in event.categories:
            event_json['@type'] = "TheaterEvent"
            event_json['workPerformed'] = {
                "@type": "TheaterPlay",
                "name": event.name,
            }

        if 'Performing Arts' in event.categories and 'Music' in event.categories:
            event_json['@type'] = "MusicEvent"
            event_json['workPerformed'] = {
                "@type": "CreativeWork",
                "name": event.name,
            }

        # Check for attachments (if image)
        if event.extra:
            for line in event.extra:
                if line.name == "ATTACH" and line.value.startswith("https"):
                    event_json["image"] = line.value
                    break

        events.append(event_json)

    return json.dumps(events, indent=2)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py input_ics_file output_json_file")
        sys.exit(1)

    input_ics_file = sys.argv[1]
    output_json_file = sys.argv[2]

    json_data = convert_ics_to_json(input_ics_file)
    
    with open(output_json_file, 'w') as output_file:
        output_file.write(json_data)
    
    print(f"JSON data saved to {output_json_file}")
