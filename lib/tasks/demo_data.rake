namespace :db do

  desc "Demo Data"
  task :demo_all => [:environment] do
    require Rails.root.join('spec', 'factories.rb')

    puts "make groups"
    parent_count = 3
    group_count = 10
    entities_per_group = 10

    parent_count.times do
      p = FactoryGirl.create(:group)
      group_count.times do
        g = FactoryGirl.create(:group)
        g.parent = p
        g.save
        entities_per_group.times do
         e = FactoryGirl.create(:entity)
         e.groups << g
        end
      end
    end

  end

end
