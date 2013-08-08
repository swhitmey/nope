Feature: Points are sent from the driver application to the friends service

	Drivers are able to see each other on a map if they have added each other to their friends list and chosen to share locations. These locations feed in from the points service.

	Background:
		Given there are two drivers driver A and driver B
		And both drivers log in and go on shift at driver_location
		And they are both friends and sharing their locations with each other

	Scenario: A driver sending good points is visible to their friend
		Given driver A opens the friends map
		And driver A can see driver B on the map at driver_location
		When driver B moves to good driver_location_2
		And driver A refreshes their map view
		Then driver A can see driver B at driver_location_2

	Scenario: A driver sending bad points is visible to their 
		Given driver A opens the friends map
		And driver A can see driver B on the map at driver_location
		When driver B moves to bad driver_location_2
		And driver A refreshes their map view
		Then driver A can see driver B at driver_location
		
		And once confidence is regained after 30 seconds
		Then driver A refreshes their map view
		And driver A can see driver B at driver_location_2

	Scenario: A driver loses and regains connectivity. The old location is remembered, and once connectivity is recovered the new location is shown
		Given driver A opens the friends map
		And driver A can see driver B on the map at driver_location
		When driver B is experiencing no connectivity
		And driver B moves to good driver_location_2
		Then driver A can see driver B at driver_location

		When driver B regains connectivity
		Then driver A refreshes their map view
		And driver A can see driver B at driver_location_2