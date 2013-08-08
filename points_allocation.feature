Feature: Points are sent from the driver application to the allocation service

	The driver's location is constantly tracked by the allocation service. The driver app needs to correctly send its location at all times.

	Background: 
		Given the driver logs in and goes on shift at driver_location
		And the passenger logs in at passenger_location

	Scenario: A driver sending good points gets their location updated
		Given the driver is visible on google earth at driver_location
		And the passenger can see a driver at driver_location
		When the driver moves to a good driver_location_2
		Then the driver is visible on google earth at driver_location_2
		And the passenger can see a driver at driver_location_2

	Scenario: A driver sending bad points gets their location updated once there is confidence in new location
		Given the driver is visible on google earth at driver_location
		And the passenger can see a driver at driver_location
		When the driver moves to a bad driver_location_2
		Then the driver is visible on google earth at driver_location
		And the passenger can see a driver at driver_location
		And once confidence is regained after 30 seconds the driver is visible on google earth at driver_location_2
		And the passenger can see a driver at driver_location_2

	Scenario: A driver loses and regains connectivity. The allocation engine remembers their last known location. Once connectivity is recovered, the new location is updated.
		Given the driver is visible on google earth at driver_location
		And the passenger can see a driver at driver_location
		When the driver is experiencing no connectivity
		And the driver moves to good driver_location_2
		Then the driver is visible on google earth at driver_location
		And the passenger can see a driver at driver_location

		When the driver regains connectivity
		Then the driver is visible on google earth at driver_location_2
		And the passenger can see a driver at driver_location_2

