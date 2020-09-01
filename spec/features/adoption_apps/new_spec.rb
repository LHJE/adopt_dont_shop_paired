
require 'rails_helper'

RSpec.describe 'when a user wants to apply to adopt a pet' do
    before :each do
      @shelter_1 = Shelter.create(name: "The Dragon's Dream",
                                 address: '1554 Diamond Lane',
                                 city: 'Destin',
                                 state: 'FL',
                                 zip: '32540')
      @pet_1 = Pet.create(image: 'TBD',
                          name: 'Drax',
                          approximate_age: '102',
                          sex: 'M',
                          shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(image: 'ETA',
                         name: 'Charlie',
                         approximate_age: '80',
                         sex: 'F',
                         shelter_id: @shelter_1.id)

      visit "/pets/#{@pet_1.id}"
      click_button "Add or Remove Pet from Favorites"
      visit "/pets/#{@pet_2.id}"
      click_button "Add or Remove Pet from Favorites"

      visit '/favorites'
    end

  it 'visits favorites page and goes to new app form' do
    expect(page).to have_link("Adopt Your Favorite Pets")

    click_link("Adopt Your Favorite Pets")

    expect(current_path).to eq("/adoption_apps/new")
  end

  it 'can select the pets at the top of the form' do
    click_link("Adopt Your Favorite Pets")

    expect(page).to have_content("Please select the pet(s) you'd like to apply for:")

    expect(page).to have_content(@pet_1.name) || have_content("You have no favorited pets!")

  end
end

# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
#





# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# - Are you a creep?
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites
