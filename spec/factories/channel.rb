FactoryGirl.define do
  factory :channel do
    slug { FFaker::Lorem.word }
    team  # cria um team random
    user { team.user }
  end
 end