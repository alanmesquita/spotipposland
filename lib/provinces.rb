require_relative 'properties'

class PropertyNotFound < Exception; end

class Provinces
  attr_reader :provinces

  def initialize(provinces_file_path)
    @provinces = load_provinces_from_file(provinces_file_path)
  end

  def properties
    @properties ||= Properties
  end

  # Get property array by given id
  #
  # @params [Int] :id the property id
  #
  # @raise [PropertyNotFound] if property id does not exists
  #
  # @return [Hash] formated response
  def get_property_by_id(id)
    property_response = properties.get_by_id(id)

    raise PropertyNotFound if property_response.nil?

    build_response [property_response]
  end

  private
  def load_provinces_from_file(provinces_file_path)
    provinces_json = ''
    File.open(provinces_file_path) do |file|
      provinces_json = file.read
    end
    JSON.parse(provinces_json)
  end

  def build_response(data)
    {
      'foundProperties': data.count,
      'properties': data
    }
  end
end
