FactoryGirl.define do
  factory :ezine_member, class: Ezine::Member do
    site_id { create(:ss_site).id }
  end
end
