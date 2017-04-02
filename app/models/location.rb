class Location
  include Mongoid::Document

  field :content, type: String
  field :latitude, type: Float
  field :longitude, type: Float
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :state_code, type: String
  field :postal_code, type: String
  field :country, type: String
  field :country_code, type: String

  validates :content, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  embedded_in :dronestrike
end
