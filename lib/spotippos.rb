require_relative 'provinces'

class ProvinceNotFound < Exception; end

class Spotippos < Provinces

  # Add a new property
  #
  # @param [PropertySchema] :property Property schema
  #
  # @return [Int] property added id
  def add_property(property)
    province_list = get_province_list(property.x, property.y)

    property.id = generate_new_id
    property.provinces = province_list
    properties.add(property.serializable_hash)

    property.id
  end

  # Get all properties in a square area
  #
  # @params [Int] :ax Left top x axis
  # @params [Int] :ay Left top y axis
  # @params [Int] :bx Bottom right x axis
  # @params [Int] :by Bottom right y axis
  #
  # @raise [PropertyNotFound] If no property is found
  #
  # @return [Hash] formated response
  def filter_properties_by_coords(ax, ay, bx, by)
    property_list = properties.all.select do |current_property|
      property_in_area?(current_property, ax, ay, bx, by)
    end

    raise PropertyNotFound if property_list.empty?

    build_response property_list
  end

  private
  # Get last property id and increment 1
  #
  # @return [Int] last property id + 1 or 1
  def generate_new_id
    last_item = properties.last

    last_item ? last_item[:id] + 1 : 1
  end

  def get_province_list(x, y)
    province_list = get_province_names_by_coords(x, y)

    raise ProvinceNotFound if province_list.empty?

    province_list
  end

  # Given a point x and y of the Cartesian plane, returns all provinces
  # belonging to that point
  #
  # @params [Int] :x Point x axis
  # @params [Int] :y Point y axis
  #
  # @return [Array] list of provinces names
  def get_province_names_by_coords(x, y)
    filtered_provinces = provinces.select do |name, bondaries|
      upperLeft = bondaries['boundaries']['upperLeft']
      bottomRight = bondaries['boundaries']['bottomRight']

      include_x = (upperLeft['x'] <= x) && (x <= bottomRight['x'])
      include_y = (y <= upperLeft['y']) && (bottomRight['y'] <= y)

      include_x and include_y
    end

    filtered_provinces.keys
  end

  # Check if the property is in the given area
  #
  # @params [Hash] :property_dict the property hash
  # @params [Int] :ax Left top x axis
  # @params [Int] :ay Left top y axis
  # @params [Int] :bx Bottom right x axis
  # @params [Int] :by Bottom right y axis
  #
  # @return [Array] list of properties found
  def property_in_area?(property_dict, ax, ay, bx, by)
    px = property_dict[:x]
    py = property_dict[:y]
    include_x = (ax <= px) && (px <= bx)
    include_y = (py <= ay) && (by <= py)

    include_x && include_y
  end
end
