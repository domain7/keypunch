Given /^I have the following groups:$/ do |table|
  table.hashes.each do |group|
    FactoryGirl.create(:group, :title => group['title'])
  end
end

Given /^every group has (\d+) entities$/ do |num|
  Group.all.each do |g|
    num.to_i.times do
      entity = FactoryGirl.build( :entity, :groups => [ FactoryGirl.build(:group, :title => g) ])
      entity.save
    end
  end
end

Given /^every group has (\d+) children$/ do |num|
  Group.all.each do |g|
    num.to_i.times do
      FactoryGirl.create(:group, :parent => g)
    end
  end
end

Given /^I navigate to the "([^"]*)" group page$/ do |title|
  @group = Group.find_by_title(title)
  visit(group_path(@group))
end

Given /^I navigate to the first child of the "([^"]*)" group page$/ do |title|
  @group = Group.find_by_title(title)
  visit(group_path(@group.children.first))
end

Then /^I should see the groups children$/ do
  @group.children.each do |node|
    page.should have_content(node.title)
  end
end

Then /^I should see the groups entities$/ do
  @group.entities.each do |e|
    page.should have_content(e.name)
  end
end
