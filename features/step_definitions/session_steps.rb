module SessionHelpers
  def default_password
    'P@ssw0rd'
  end

  def weak_password
    'password'
  end

  def default_user
    u = FactoryGirl.create(:user)
    my_role = Role.find_or_create_by_name({:name => 'user' })
    my_role.save
    u.roles << my_role
    u.save
    u
  end
end
World(SessionHelpers)

Given /^I am not logged in$/ do
  steps %{When I go to the logout page}
end

When /^I logout$/ do
  page.click_link("Logout")
end

When /^I sign out$/ do
  steps %Q{
    Given I am not logged in
  }
end

Given /^no account exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Then /^I should be signed in$/ do
  steps %{
    And I should see "Logout" within ".user-nav"
    And I should not see "Login" within ".user-nav"
  }
end

Then /^I should be signed out$/ do
  steps %{
    And I should see "Login" within ".user-nav"
    And I should not see "Logout" within ".user-nav"
  }
end

When /^I login with email "(.*)" and password "(.*)"$/ do |email, password|
  visit(new_user_session_path)
  page.fill_in 'Email', :with => "#{email}"
  page.fill_in 'Password', :with => "#{password}"
  page.click_button("Login")
end

When /^I login as an authenticated user$/ do
  user = default_user
  page.fill_in 'Email', :with => "#{user.email}"
  page.fill_in 'Password', :with => "#{default_password}"
  page.click_button("Login")
end

When /^I login as an invalid user$/ do
  steps %{ Given I login with email "#{Faker::Internet.email}" and password "#{default_password}"}
end

When /^I attempt to login with an invalid password$/ do
  user = default_user
  steps %{ Given I login with email "#{user.email}" and password "this_password_is_incorrect"}
end

Given /^I am logged in$/ do
  user = default_user
  steps %{
    Given I login with email "#{user.email}" and password "#{default_password}"
    Then I should see a successful login message
  }
end

Given /^I am logged in as an (.*)$/ do |role|
  u = FactoryGirl.create(:user)
  my_role = Role.find_or_create_by_name({:name => role.downcase })
  my_role.save
  u.roles << my_role
  steps %{
    Given I login with email "#{u.email}" and password "#{default_password}"
    Then I should see a successful login message
  }
end

Given /^I have the following users:$/ do |table|
  table.hashes.each do |user|
    u = FactoryGirl.create(:user, :email => user['email'])
  end
end

Given /^I have the following ACL roles:$/ do |table|
  table.hashes.each do |r|
    u = FactoryGirl.create(:role, :name => r['role'])
  end
end

Given /^I have signed in$/ do
  steps %{Given I am logged in}
end

Then /^I should see an invalid login message$/ do
  page.should have_content('Invalid email or password.')
end

Then /^I should see a successful login message$/ do
  page.should have_content('Signed in successfully.')
end

Then /^I should see a successful logout message$/ do
  page.should have_content('Signed out successfully.')
end

Then /^I should see a successful google auth message$/ do
  page.should have_content('Successfully authenticated from Google Apps account.')
end

When /^I attempt to reuse a password$/ do
  user = User.last
  visit(edit_user_path(user))
  page.fill_in 'Password', :with => default_password
  page.fill_in 'Password confirmation', :with => default_password
  page.click_button("Save")

  visit(edit_user_path(user))
  page.fill_in 'Password', :with => default_password
  page.fill_in 'Password confirmation', :with => default_password
  page.click_button("Save")
end

When /^I attempt to use a weak password$/ do
  user = User.last
  visit(edit_user_path(user))
  page.fill_in 'Password', :with => weak_password
  page.fill_in 'Password confirmation', :with => weak_password
  page.click_button("Save")
end

Then /^I should see password has been used message$/ do
  page.should have_content('has been used previously')
end

Then /^I should see password is too simple message$/ do
  page.should have_content('must contain at least one uppercase letter')
end

Then /^I should see a successful user update message$/ do
  page.should have_content('User was successfully updated.')
end

Then /^I should see all the ACL roles "(.*)" belongs to/ do |email|
  User.find_by_email(email).roles.each do |role|
    steps %{
    Then I should see "#{role.name}" within "#role_ids"
    }
  end
end

Then /^I should see that this user is (now|not) associated to the "(.*?)" ACL role$/ do |negate, role|
  if negate == 'not'
    steps %{
    Then I should not see "#{role}" within "#role_ids"
    }
  else
    steps %{
    Then I should see "#{role}" within "#role_ids"
    }
  end
end

Given /^the following user ACL roles have been setup:$/ do |table|
#|role|email|
  table.hashes.each do |user|
    u = User.find_by_email(user['email']) || FactoryGirl.create(:user, :email => user['email'])
    r = Role.find_or_create_by_name(user['role'])
    r.save
    u.roles << r
    u.save
  end
end

Given /^I am logged in as user "(.*)"$/ do |user|
  steps %{
    Given I login with email "#{user}" and password "#{default_password}"
    Then I should see a successful login message
  }
end


Then /^I should not see the access denied error$/ do
    steps %{
    Then I should not see "You do not have acess to this page."
    }
end

Then /^I should see the access denied error$/ do
    steps %{
    Then I should see "You do not have acess to this page."
    }
end
