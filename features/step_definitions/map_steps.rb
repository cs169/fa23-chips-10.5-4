# Click on
Given('I am on the national map') do
  visit root_path
end

When('I click on the state with name {string}') do |state_code|
  visit "/state/#{state_code}"
end

Given('I am on the state {string} page') do |state_code|
  visit "/state/#{state_code}"
end

When('I click on {string} County {string} in {string}') do |county, county_code, state|
  visit "/search/#{county}%20County,%20#{state},%20#{county_code}"
end
