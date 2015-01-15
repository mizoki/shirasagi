FactoryGirl.define do
  factory :ezine_node_page, class: Ezine::Node::Page, traits: [:cms_node] do
    route "ezine/page"
  end
end
