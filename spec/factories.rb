require 'factory_girl'
require 'faker'
FactoryGirl.define do
  sequence :user_email do |n|
    "user#{n}@example.com"
  end

  sequence :group_title do |n|
    "group#{n}"
  end

  factory :user, :class => User do
    email                 { FactoryGirl.generate :user_email }
    first_name            { Faker::Name.first_name }
    last_name             { Faker::Name.last_name }
    password              'P@ssw0rd'
    password_confirmation 'P@ssw0rd'
  end

  factory :admin_user, parent: :user do
    association :role, factory: :role, name: 'admin'
  end

  factory :role, class: Role do
    name 'user'
  end

  factory :group, :class => Group do
    title { FactoryGirl.generate :group_title }
  end

  factory :entity, :class => Entity do
    name          { Faker::Internet.domain_word }
    username      { Faker::Internet.user_name }
    password      'P@ssw0rd'
    description   { Faker::Lorem.sentence(5) }
    protocol      'https'
    domain        { Faker::Internet.domain_name }
    expire_at     { Time.now + 1.year }
    groups {|groups| [groups.association(:group)]}
    #e.association :group, :factory => :group
  end
end
