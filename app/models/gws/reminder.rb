class Gws::Reminder
  include SS::Document
  include Gws::Reference::User
  include Gws::Reference::Site
  include SS::UserPermission

  seqid :id
  field :name, type: String
  field :url, type: String
  field :date, type: DateTime
  field :item_collection, type: String
  field :item_id, type: String

  permit_params :name, :url, :date, :item_collection, :item_id

  validates :name, presence: true
  validates :url, presence: true

  default_scope -> {
    order_by date: 1
  }
  scope :search, ->(params) {
    criteria = where({})
    return criteria if params.blank?

    criteria = criteria.keyword_in params[:keyword], :name if params[:keyword].present?
    criteria
  }
end