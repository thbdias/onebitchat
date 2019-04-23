FactoryBot.define do
  factory :message do
    body    { FFaker::Lorem.sentence }
    user    # cria um user random
  end
 end