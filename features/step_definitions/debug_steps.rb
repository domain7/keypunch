Then /^show me the page$/ do
  save_and_open_page
end

Then "debug" do
  require 'ruby-debug'
  debugger
  0
end

Then "what" do
  display do
    where
    html
    how
    where
  end
end

Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    FactoryGirl.create(factory, hash)
  end
end

Given /^(?:|I have )(\d+) (.+) records?$/ do |qty, factory|
  (qty.to_i <= 0 ? 1 : qty).to_i.times do
    FactoryGirl.create(factory)
  end
end

module DebugHelpers
  def where
    # Capybara
    # page.driver.request.session
    # page.driver.request.env
    # cookies = Capybara.current_session.driver.current_session.instance_variable_get(:@rack_mock_session).cookie_jar
    ######puts "#{@request.env["SERVER_NAME"]}#{@request.env["REQUEST_URI"]}"
    puts "#{page.driver.request.env["SERVER_NAME"]}#{page.driver.request.env["REQUEST_URI"]}"
  end

  def how
    puts page.driver.request.params.inspect
  end

  def html
    #puts @response.body.gsub("\n", "\n            ")
    puts page.body.gsub("\n", "\n            ")
  end

  def display(decoration="\n#{'*' * 80}\n\n")
    puts decoration
    yield
    puts decoration
  end
end
World(DebugHelpers)
