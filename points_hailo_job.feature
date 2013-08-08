Feature: Points are sent from the driver application during a hailo job

  In order to track the location of drivers, the driver application sends points to the API. The API then records these points, and uses them in various services (jstats, job/info and job maps).
  Due to the accuracy of GPS systems on phones, sometimes the reported positions will have high confidence, and others will have low confidence. This confidence is decided by the driver app, and then sent as metadata with the points data.

  Background:
  	Given the driver logs in and goes on shift at driver_location
    And the passenger logs in at passenger_location
    And the passenger arranges a hailo job with the driver
    And the driver arrives
    And the passenger should be notified that his cab is ready
    And the driver goes POB
    And the passenger has to be on board

  Scenario: A driver sending good points
  	Given the driver moves through good_driver_path
  	When the driver is sending good points
  	And the driver takes payment
  	Then the passenger should see the receipt
  	And all good_driver_path points should be recorded in jstats with high confidence
  	And all good_driver_path points should be recorded in job/info with high confidence
  	And the job map on Elastic Ride should display all good_driver_path points

  Scenario: A driver sending bad points
  	Given the driver moves through bad_driver_path
  	When the driver is sending bad points
  	And the driver takes payment
  	Then the passenger should see the receipt
  	And all bad_driver_path points should be recorded in jstats with low confidence
  	And all bad_driver_path points should be recorded in job/info with low confidence
  	And the job map on Elastic Ride should display all bad_driver_path points with low confidence

  Scenario: A driver with poor connectivity recovers their connection and sends a batch of points
  	Given the driver is experiencing no connectivity
  	And the driver moves through good_driver_path
  	When the driver is sending good points
  	And the driver takes payment
  	And the driver regains connectivity
  	Then the passenger should see the receipt
  	And all good_driver_path points should be recorded in jstats with high confidence
  	And all good_driver_path points should be recorded in job/info with high confidence
  	And the job map on Elastic Ride should display all good_driver_path points with high confidence