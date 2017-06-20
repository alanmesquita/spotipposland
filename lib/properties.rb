# This class manages the properties, nothing will be persisted, everything
# will be in memory
class Properties
  class << self
    def add(data)
      properties.push(data)
    end

    def all
      properties
    end

    # Get property array by given id if it not 0
    #
    # @params [Int] :id the property id
    #
    # @return [Hash] propery hash
    def get_by_id(id)
      id = id.to_i
      property_response = id > 0 ? properties[id -1] : nil
      return property_response if property_response.nil?

      property_response
    end

    def last
      properties.last
    end

    private
    def properties
      @properties ||= []
    end
  end
end
