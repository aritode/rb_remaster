module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessors_with_history(*args)
      args.each do |name|
        define_method(name) do
          instance_variable_get("@#{name}")
        end

        define_method("#{name}=") do |value|
          history_array = instance_variable_get("@#{name}_history")
          history_array ||= [] and history_array << value

          instance_variable_set("@#{name}_history", history_array)
          instance_variable_set("@#{name}", value)
        end

        define_method("#{name}_history") do
          instance_variable_get("@#{name}_history") || []
        end
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      define_method(attr_name) do
        instance_variable_get("@#{attr_name}")
      end

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
