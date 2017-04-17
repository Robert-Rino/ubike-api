require 'mongoid'

class Station
  include Mongoid::Document
  field :sno, type: String
  field :name, type: String
  field :tot, type: Integer
  field :sbi, type: Integer
  field :lat, type: Float
  field :lng, type: Float
  field :mday, type: Integer
  field :full, type: Boolean
  field :empty, type: Boolean
  field :updatetime, type:Integer, default: Time.now.to_i
end
