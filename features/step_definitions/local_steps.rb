Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I follow "([^"]*)"$/ do |link|
  click_link(link)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |field, value|
    fill_in(field, :with => value)
  end
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )unselect "([^"]*)" from "([^"]*)"$/ do |value, field|
  unselect(value, :from => field)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should_not
    page.should_not have_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should see "([^"]*)" within "([^"]*)"$/ do |text, locator|
  within(locator) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should not see "([^"]*)" within "([^"]*)"$/ do |text, locator|
  within(locator) do
    if page.respond_to? :should_not
      page.should_not have_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end
