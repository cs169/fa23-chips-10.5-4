
# Click on  
Given("I am on the national map") do
  visit root_path
end

When("I click on the state with name {string}") do |state_name|
   # Ask Team
   puts "hi"
end


Given("I am on the state {string} page") do |state_code|
  # Assuming the state code is provided in uppercase (e.g., 'CA')
  state_code = state_code.upcase

  # Build the URL for the state page
  state_page_url = "/state/#{state_code}"

  # Visit the constructed URL
  visit "#{root_path}#{state_page_url}"
end
