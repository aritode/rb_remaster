module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def add_attribute_reader(name)
      define_method(name) do
        instance_variable_get("@#{name}")
      end
    end

    def attr_accessors_with_history(*args)
      args.each do |attr_name|
        attr_name_history = "#{attr_name}_history"

        add_attribute_reader attr_name

        define_method(attr_name_history) do
          instance_variable_get("@#{attr_name_history}") || []
        end

        define_method("#{attr_name}=") do |value|
          history_array = self.send(attr_name_history) << value

          instance_variable_set("@#{attr_name_history}", history_array)
          instance_variable_set("@#{attr_name}", value)
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      add_attribute_reader attr_name

      define_method("#{attr_name}=") do |value|
        if value.is_a? attr_class
          instance_variable_set("@#{attr_name}", value)
        else
          raise TypeError, "Class of value: #{value} is not #{attr_class}"
        end
      end
    end
  end
end
