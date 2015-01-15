FactoryGirl.define do
  factory :ezine_page, class: Ezine::Page, traits: [:cms_page] do
    route "ezine/page"
  end
end
