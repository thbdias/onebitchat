FactoryGirl.define do
  factory :talk do
    user_one { create(:user) }
    user_two { create(:user) }
    team     # cria um team random
  end
 end