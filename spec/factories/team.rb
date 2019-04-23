FactoryBot.define do
  factory :team do
    slug    { FFaker::Lorem.word }
    user    # cria um user random 
  end
 end