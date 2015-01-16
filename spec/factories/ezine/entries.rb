FactoryGirl.define do
  factory :ezine_entry, class: Ezine::Entry do
    site_id { create(:ss_site).id }
  end
end
