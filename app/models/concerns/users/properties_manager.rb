module Users
  module PropertiesManager
    extend ActiveSupport::Concern

    included do
      has_many :user_properties, dependent: :destroy
      attribute :properties
    end

    def get_property(property_name)
      user_properties.where(name: property_name).first.try(:value)
    end

    def set_property(property_name, property_value)
      user_property = user_properties.where(name: property_name).first_or_initialize
      user_property.value = property_value

      user_property.save!
    end

    def properties=(properties)
      properties.each do |property_name, property_value|
        set_property(property_name, property_value)
      end
    end

    def properties
      user_properties.inject({}) do |result, property|
        result[property.name] = property.value
        result
      end
    end

    def as_json(options={})
      super().merge("properties" => properties)
    end
  end
end
