require 'rails_helper'

RSpec.feature "MakeAndModels", type: :feature do
  # Context simply explains something that is common for the its in the container
  context "As an internet user, " do
    # "it"s are the test case for each story inside the context and feature
    it "As an internet user, I can visit a page that shows Welcome to the Car Simulator" do
      visit "/car/create"
      expect(page).to have_content("Welcome to the Car Simulator!")
    end

    # tests to make sure that the make and model year have fields on the create car page
    it "when I visit the welcome page, I am asked for make and model year of the car." do
      visit "/car/create"
      expect(page).to have_field("Make")
      expect(page).to have_field("Model Year")
    end

    # tests to make sure that the simulate car button doesn't show the next page if the user hasn't entered anything for make and model year
    it " If a user doesn't enter make and model year, and clicking on a button labelled Simulate Car, it loads the main page" do
      visit "/car/create"
      click_button "Simulate Car"
      # no parameters load the same page again
      expect(page.current_path).to eq('/car/create')
    end

    # tests to make sure that the simulate car button works
    it "after entering make and model year, and clicking on a button labelled Simulate Car I am taken to a status page showing make and model year of the car." do
      visit "/car/create"
      fill_in("Make", with: "Mini")
      fill_in("Model Year", with: 2012)
      click_button "Simulate Car"

      expect(page).to have_content("Mini")
      expect(page).to have_content("2012")
      expect(page.current_path).to eq('/simulator/status')
    end

    # tests to make sure that the lights of the car are shown
    it "visit the status page for a selected car, it shows whether the lights on the car is on or off. They start off." do
      fill_in_make_and_modelyear
      expect(page).to have_button("Off")
      # Below will load the page and show at that point in the test
      # save_and_open_page
    end

    # tests to make sure that the light status of the car is diplayed in a button that also toggles the lights
    it "visit the status page for a selected car, it shows whether the lights on the car is on or off. Toggle them on." do
      fill_in_make_and_modelyear
      click_button "Off"
      expect(page).to have_button("On")
      # save_and_open_page
    end

    # tests to make sure that the current speed of the car is displayed.
    it "when I visit the car status page, I can see the cars current speed. It starts at zero" do
      fill_in_make_and_modelyear
      expect(page).to have_selector("h2[id='speed']", text: "0mph")
    end

    # tests to make sure that the accelerate button makes the car speed up
    it "I can click on an accelerate button, which makes the car go faster, and which is shown in the car status page." do
      fill_in_make_and_modelyear
      click_button "Accelerate"

      expect(page).to have_selector("h2[id='speed']", text: "10mph")

      click_button "Accelerate"
      expect(page).to have_selector("h2[id='speed']", text: "20mph")
    end

    # tests to make sure that the brake button makes the car slow down
    it "I can click on an brake button, which makes the car go slower, and which is shown in the car status page." do
      fill_in_make_and_modelyear
      click_button "Accelerate"
      click_button "Accelerate"
      click_button "Accelerate"
      click_button "Brake"

      expect(page).to have_selector("h2[id='speed']", text: "20mph")

      click_button "Brake"
      expect(page).to have_selector("h2[id='speed']", text: "10mph")
    end

    # tests to make sure that the parking brake works and does not let the car accelerate if it is set.
    it " I can set and release the parking brake using radio buttons." do
      fill_in_make_and_modelyear
      click_button "Accelerate"
      expect(page).to have_selector("h2[id='speed']", text: "10mph")
      click_button "Brake"
      choose("On")
      click_button "Set Parking Brake"
      click_button "Accelerate"
      expect(page).to have_selector("h2[id='speed']", text: "0mph")
    end

    # tests to make sure that the description of the car shows on the status page.
    it "I can enter a description of the on the welcome page, and it is shown on the status " do
      fill_in_make_and_modelyear
      expect(page).to have_content("This is the description for our car! It is a great car.")
    end

  end

# Method that goes to our create car page, fills in the make, model year, description, and then clicks the simulate car button
  def fill_in_make_and_modelyear
    visit "/car/create"
    fill_in("Make", with: "Mini")
    fill_in("Model Year", with: 2012)
    fill_in("Description", with: "This is the description for our car! It is a great car.")
    click_button "Simulate Car"
  end
end
