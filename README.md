# DONE

We either have URLs that can be easily scraped (https://schema.org/Event), or a file with enough details to recreate it.

| Source                         | Scraped | Parsed | In Database | Notes                                                                                                     |
|:-------------------------------|:--------|:-------|:------------|:----------------------------------------------------------------------------------------------------------|
| AllEvents.in                   | ✔️      | ✔️     | ✔️          |                                                                                                           |
| HighApe.com                    | ✔️      | ✔️     | ✔️          |                                                                                                           |
| map-india.org                  | ✔️      | ✔️     | ✔️          | Only events, exhibits are not tracked yet
| BIC                            | ✔️      | ✔️     | ✔️          | Converted from ICS Calendar                                                                               |
| Paytm Insider                  | ✔️      | ✔️     | ✔️          |                                                                                                           |
| Bengaluru Sustainability Forum | ✔️      | ✔️     | ❌           |                                                                                                           |
| Bhaago India                   | ✔️      | ✔️     | ✔️          |                                                                                                           |
| Carbon Science Gallery         | ✔️      | ✔️     | ✔️           |                                                                                                           |
| Max Mueller Bhavan             | ✔️      | ✔️     | ✔️          |                                                                                                           |
| https://events.venn.buzz/      | ✔️      | ✔️     | ❌           |                                                                                                           |
| https://linktr.ee/atta_galatta | ✔️      | ✔️     | ❌           |                                                                                                           |
| Zomato                         | ✔️      | ✔️     | ❌           |                                                                                                           |
| Champaca                       | ✔️      | ✔️     | ✔️           |                                                                                                           |
| [Visvesvaraya Museum][vism].   | ❌      | ❌     | ❌           | OCR                                                                                                       |
| [NGMA][ngma]                   | ❌      | ❌     | ❌           | OCR The [older website calender](http://www.ngmaindia.gov.in/ngma_bangaluru_calendar.asp) is not updated. |
| [Sofar][sofar]                 | ✔️      | ✔️     | ✔️          |                                                                                                           |
| [Sumukha gallery][sumukha]     | ✔️      | ✔️     | ✔️          | 
| [Townscript][ts]			     | ✔️      | ✔️     | ✔️          | Lahe Lahe, Broke Bibliophiles, Foodwize. Suggestions welcome for more events that use TownScript
| [Blue Tokai][bt]			     | ✔️      | ✔️     | ✔️          | Some location guesswork
| [Gully Tours][gt]			     | ✔️      | ✔️     | ✔️          |  Sticker Price used, child pricing ignored
# WIP

We have some data available or change notifications configured, but there needs to be more work to recreate the events.

- [ ] [ICTS](https://www.icts.res.in/current-and-upcoming-events)
- [ ] lu.ma (Uses G-CSE, since no public calendars)
- [ ] Urbanaut
- [x] https://thecourtyard.in/events/ Courtyard is only using Urbanaut, so covered already
- [ ] https://www.blrcreativecircus.com/events
- [x] https://gameslab.wootick.com/ Covered via Insider, maybe add a filter

# TODO
- [ ] https://hooplaback-girl.myinstamojo.com/ (search for Workshop events)
- [ ] https://gaianaturalproductsandservices.myinstamojo.com/category/419534/events
- [ ] https://courtyardkoota.com
- [ ] https://dialogues.space/events/
- [ ] bookmyshow plays
- [ ] [Instagram](instagram.txt)
- [ ] http://1shanthiroad.com/category/events/
- [ ] https://gullytours.vacationlabs.com/ -> Go to booking page to see valid dates. Couldn't find any other "good" vacationlabs domains.
- [ ] find more Townscript accounts to follow
- [ ] https://www.tonight.is/. Some GRPC Firebase :poop:
- [ ] https://www.downtomeet.com/
- [ ] Go through PS archives to see other venue hosts.
- [ ] [Indian Music Experience](https://indianmusicexperience.org/events/)
- [ ] [Parallel Cinema Club](https://www.theparallelcinema.club/events)
- [ ] [Maverick](https://www.maverickandfarmer.com/)
- [ ] https://www.meinbhikalakar.com/upcomingworkshops
- [ ] https://www.paintbar.in/collections/paint-bar-bangalore
- [ ] https://www.pedalintandem.com/experiences
- [ ] https://lockthebox.in/upcoming-events.php
- [ ] https://manjushreekhaitanfoundation.com/?post_type=tribe_events&eventDisplay=list
- [ ] https://sistersinsweat.in/events?city=4
- [ ] https://nd.jpf.go.jp/events/coming-events-announcements/
## Known Issues

- [ ] Events with multiple dates are not handled well. Need to split them into separate events. Examples: 
	[1](https://allevents.in/bangalore/80004382397903), [2](https://insider.in/private-clay-dates-create-pottery-with-loved-ones-jun19-2023/event)

## Venues in BLR
- [ ] [IIHS](https://iihs.co.in/iihs-events/)
- [ ] https://en.wikipedia.org/wiki/Karnataka_Chitrakala_Parishath
- [ ] https://en.wikipedia.org/wiki/Venkatappa_Art_Gallery
- [ ] https://en.wikipedia.org/wiki/Gandhi_Bhavan,_Bengaluru
- [ ] https://en.wikipedia.org/wiki/Government_Museum,_Bangalore
- [ ] https://en.wikipedia.org/wiki/HAL_Aerospace_Museum
- [ ] https://en.wikipedia.org/wiki/Law_Museum_Bangalore
- [ ] https://en.wikipedia.org/wiki/Kempegowda_Museum
- [ ] https://en.wikipedia.org/wiki/Sandesh_Museum_of_Communication

[vism]: https://www.vismuseum.gov.in/special_events/upcoming-events-2/
[sofar]: https://www.sofarsounds.com/cities/bangalore
[sumukha]: https://sumukha.com
[ts]: https://www.townscript.com/
[bt]: https://bluetokaicoffee.com/pages/events-new
[gt]: https://www.gully.tours/tours