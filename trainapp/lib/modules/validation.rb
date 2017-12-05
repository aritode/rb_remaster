# frozen_string_literal: true
module Validation
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def validations
      @validations ||= {}
    end

    def validate(attr_name, type, options = nil)
      validations[attr_name] ||= []
      validations[attr_name] << [type, options]
    end
  end

  def validate!
    self.class.validations.each do |attr_name, params|
      params.each do |method_name, option|
        attr_name_value = instance_variable_get("@#{attr_name}")
        send(method_name, attr_name, attr_name_value, option)
      end
    end
  end

  def valid?
    !!validate!
  rescue
    false
  end

  protected

  def presence(attr_name, attr_name_value, _option)
    if attr_name_value.nil? || attr_name_value.to_s.empty?
      raise "#{self.class} @#{attr_name} can't be empty"
    end
  end

  def format(attr_name, attr_name_value, option)
    if attr_name_value !~ option
      raise "#{self.class} must be with correct @#{attr_name} format: #{option}"
    end
  end

  def type(attr_name, attr_name_value, option)
    message = "#{self.class} @#{attr_name} must be correct type: #{option}"
    raise message unless attr_name_value.is_a?(option)
  end
end
