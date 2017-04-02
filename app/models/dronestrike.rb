class Dronestrike  
  include Mongoid::Document

  embeds_one :location

  field :date, type: String
  field :description, type: String
  field :injured, type: String
  field :killed, type: String
  field :name, type: String
  field :references, type: String
  field :type, type: String
  field :wounded, type: String

  validates :date, presence: true
  validates :description, presence: true
  validates :name, presence: true

  validates :description, :uniqueness => { :scope => :date } 
end
