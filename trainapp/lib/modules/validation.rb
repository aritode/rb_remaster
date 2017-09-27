# frozen_string_literal: true
module Validation
  def valid?
    validation!
  rescue
    false
  end
end
