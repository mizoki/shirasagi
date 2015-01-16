FactoryGirl.define do
  factory :ezine_test_member, class: Ezine::TestMember do
    site_id { create(:ss_site).id }
  end
end
