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

When('I click on the county with name {string} County and code {string} in state {string}') do |county, county_code, state_code|
  visit "/search/#{county}%20County,%20#{state_code},%20#{county_code}"
end
