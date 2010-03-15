Given /^I have facebook instance configured$/ do
  @current_facebook = Facebook.new({
    :api_key => 'api-key',
    :secret_key => 'secret-key'
  })
end

When /^I ask for the current Facebook session$/ do
  @current_facebook.session
end

Then /^I should retrieve the current Facebook session$/ do
  pending # express the regexp above with the code you wish you had
end