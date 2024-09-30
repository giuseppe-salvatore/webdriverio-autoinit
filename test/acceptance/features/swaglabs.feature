@swaglab-app
Feature: Swaglabs application

Scenario: Logon to swaglabs
  Given I am on the swaglabs application page
  When I login to the application
  Then I should see the six product list items

Scenario: Verify the swaglabs application login error message
  Given I am on the swaglabs application page
  When I try to login to the application with incorrect credentials
  Then I should see login error message

Scenario: Verify swaglabs product seletion view
  Given I am on the swaglabs application page
  And I login to the application
  When I select a product
  Then I should see the product details

Scenario: Verify the swaglabs application add to cart functionality
  Given I am on the swaglabs application page
  And I login to the application
  When I add a product to my cart
  Then I should see the cart update with the added product

Scenario: Verify the swaglabs application cart page
  Given I am on the swaglabs application page
  And I login to the application
  When I add a product to my cart
  Then I should be able to see my cart page

Scenario: Verify the swaglabs application check out page
  Given I am on the swaglabs application page
  And I login to the application
  When I add a product to my cart
  Then I should be able to check out item

Scenario: Verify the swaglabs application logout
  Given I am on the swaglabs application page
  And I login to the application
  When I logout of the application
  Then I should see the login option available