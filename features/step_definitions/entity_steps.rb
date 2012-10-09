Given /^I visit the entities page$/ do
  visit(entities_path)
end

Then /^I should see a list of entities by group, with a title\.$/ do
  locator = "table#entities thead tr th a"
  page.should have_content('Group')
  page.should have_content('Name')
end

When /^I order by "([^"]*)"$/ do |sort_by|
  locator = "table thead tr th a"
  click_link(sort_by)
end

Then /^I should see entities ordered by "([^"]*)"$/ do |sort_by|
  noko = Nokogiri::HTML page.body
  entities = Entity.order(sort_by)

  noko.css('.entity').each_with_index do |row_item,row_index|
    row = table.hashes[ row_index ]
    entity = entitie[ row_index - 1 ]
    assert_equal(ActionController::RecordIdentifier.dom_id(entity), row_item.attributes['id'].value)
  end
end

Given /^I have the following entities:$/ do |table|
#|group_title|entity_name|
  table.hashes.each do |e|
    g = Group.find_or_create_by_title(e['group_title'])
    FactoryGirl.create(:entity, :groups => [g], :name => e['entity_name'])
  end
end

When /^I search for "([^"]*)"$/ do |search|
  @search_results = Entity.search(search)
  page.fill_in 'Search', :with => "#{search}"
  page.click_button('Search')
end

Then /^I should see the following search results:$/ do |table|
  noko = Nokogiri::HTML page.body
  noko.css('.entity').each_with_index do |row_item,row_index|
    row = table.hashes[ row_index ]
    entity = @search_results[ row_index - 1 ]
    assert_equal(ActionController::RecordIdentifier.dom_id(entity), row_item.attributes['id'].value)
  end
end

Then /^I should see all the entities filtered by group "([^"]*)"$/ do |group|
  Group.find_by_title(group).entities.each do |e|
    page.should have_css('#' + ActionController::RecordIdentifier.dom_id(e))
  end
end

Then /^I should see the following entity attributes:$/ do |fields|
  fields.rows.each do |attribute|
    page.should have_content(attribute.first)
  end
end

Then /^the new entity is created$/ do
  page.should have_content('Password was successfully created.')
end

When /^I fill in the entity fields$/ do
  page.fill_in("Name", :with => "New Key")
  page.fill_in("Username", :with => "MYUSER")
  page.fill_in("URL", :with => "https://chnl7.com")
  page.fill_in("Password", :with => "P@ssw0rd")
  page.fill_in("Password confirmation", :with => "P@ssw0rd")
  page.fill_in("Description", :with => "Description")
  page.fill_in("Protocol", :with => "https")
end

Then /^I should see a successful entity update message$/ do
  page.should have_content('Password was successfully updated.')
end

Then /^I should see all the ACL roles "(.*)" entity belongs to/ do |name|
  Entity.find_by_name(name).roles.each do |role|
    steps %{
    Then I should see "#{role.name}" within "#role_ids"
    }
  end
end

Then /^I should see that this entity is (now|not) associated to the "(.*?)" ACL role$/ do |negate, role|
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

Then /^I should see all the users "(.*)" entity belongs to/ do |name|
  Entity.find_by_name(name).users.each do |user|
    steps %{
    Then I should see "#{user.email}" within "#user_ids"
    }
  end
end

Then /^I should see that this entity is (now|not) associated to the "(.*?)" user$/ do |negate, user|
  if negate == 'not'
    steps %{
    Then I should not see "#{user}" within "#user_ids"
    }
  else
    steps %{
    Then I should see "#{user}" within "#user_ids"
    }
  end
end

Given /^the following entities have the following permissions:$/ do |table|
#|entity_name|roles|emails|
  table.hashes.each do |row|
    e = Entity.find_by_name(row['entity_name'])
    e.roles.clear
    e.users.clear
    row['roles'].split(',').each do |role|
      e.roles << Role.find_by_name(role)
    end
    row['emails'].split(',').each do |email|
      e.users << User.find_by_email(email)
    end
    e.save
  end
end

Then /^I should be able to access entity "(.*?)"$/ do |entity|
    steps %{
      When I go to the edit entity page for "#{entity}"
      Then I should not see the access denied error
    }
end

Then /^I should not be able to access entity "(.*?)"$/ do |entity|
    steps %{
      When I go to the edit entity page for "#{entity}"
      Then I should see the access denied error
    }
end
