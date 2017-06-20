require 'active_model'

MAX_BEDS = 5
MAX_BATHS = 4
MAX_SQUARE_METRES = 240
MINIMUN_SQUARE_METRES = 20
SQUARE_METRES_VALIDATION_MESSAGE = "should be between #{MINIMUN_SQUARE_METRES} " \
                                   "and #{MAX_SQUARE_METRES}"

# This class is responsible for validating the schema of the property,
# everything that belongs to the property must be in this classse
#
# @params [Hash] opts the options to validate the property with:
# @params opts [Int] :x The property x coordinates
# @params opts [Int] :y The property y coordinates
# @params opts [String] :title The property title
# @params opts [Int] :price The property price
# @params opts [String] :description The property description
# @params opts [Int] :beds The property beds quantity
# @params opts [Int] :baths The property baths quantity
# @params opts [Int] :squareMeters The property square meters
class PropertySchema
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :x, :y, :title, :price, :description, :beds, :baths, :squareMeters,
                :id, :provinces


  validates_presence_of :x, :y, :title, :price, :description, :beds, :baths, :squareMeters

  # Validates if squareMeters is in range
  validates_inclusion_of :squareMeters,
                         in: MINIMUN_SQUARE_METRES..MAX_SQUARE_METRES,
                         message: SQUARE_METRES_VALIDATION_MESSAGE

  validates_numericality_of :beds, less_than_or_equal_to: MAX_BEDS
  validates_numericality_of :baths, less_than_or_equal_to: MAX_BATHS

  # Method used by ActiveModel::Serialization to return the specified hash
  # on return of this method
  def attributes
    {
      id: nil,
      x: x,
      y: y,
      title: title,
      price: price,
      description: description,
      beds: beds,
      baths: baths,
      squareMeters: squareMeters,
      provinces: nil
    }
  end
end
