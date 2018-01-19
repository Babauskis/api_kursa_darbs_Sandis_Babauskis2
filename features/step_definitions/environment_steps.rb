When (/^I log in apimation.com as a regular user again$/) do
  login_positive
end

When (/^I create a new environment with name: (.*)$/) do |environment|
  create_environment(environment)
end

Then(/^I check if I added an environment with name: PREFROD$/) do
  check_environment
end

And(/^I create an global variable called (.*) with value (.*)$/) do |glob_var_name,value|
  create_global_variable(glob_var_name,value)
end

Then(/^I create a collection with name: (.*)$/) do |collection_name|
  create_collection(collection_name)
end

Then(/^I create apimation.com request for login$/) do
  create_login_request
end