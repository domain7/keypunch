When /^I change the value of the hidden field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  xpath = %{//input[@type="hidden" and @name="#{field_name}"]}
  page.find(:xpath, xpath).set(value)
end

When /^I change the value of the select field "([^\"]*)" to "([^\"]*)"$/ do |field_name, value|
  xpath = %{//input[@type="select" and @name="#{field_name}"]}
  page.find(:xpath, xpath).set(value)
end

Then /^I should see "([^"]*)" in the "([^"]*)" flash message$/ do |content, flash_type|
  steps %{Then I should see "#{content}" within ".#{flash_type}"}
end

Then /^I should get a response code of "(\d+)"$/ do |http_status|
  assert_equal(http_status.to_i, page.status_code.to_i)
end

When /^I visit "([^"]*)"$/ do |url|
  visit(url)
end

Then /^I should get a download with the filename "([^\"]*)"$/ do |filename|
  page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
end

Then /^the html returned should contain "([^"]*)"$/ do |content|
  page.html.index(content)
end

When /^I (press|follow|check|uncheck|choose) "([^\"]*)" for (.*) whose (.*) is "([^\"]*)"$/ do |action, whatyouclick, class_name, var_name, value|
  unless var_name == "id" then
    id = eval("\"#{class_name}\".classify.constantize.find_by_#{var_name}(\"#{value}\").id.to_s")
  else
    id = value
  end
  within("tr[id=row_#{class_name}_#{id}]") do
    case action
    when "press"
      click_button(whatyouclick)
    when "follow"
      click_link(whatyouclick)
    when "check"
      check(whatyouclick)
    when "uncheck"
      uncheck(whatyouclick)
    when "choose"
      uncheck(whatyouclick)
    end
  end
end

When /^I uncheck everything$/ do
  all('input[@type=checkbox]').each do |c|
    uncheck(c[:name])
  end
end

When /^I check everything$/ do
  all('input[@type=checkbox]').each do |c|
    uncheck(c[:name])
  end
end
