# frozen_string_literal: true

module Plantae
  # Represents a scenario
  class Scenario
    attr_reader :name, :block

    # @param name [String] scenario name
    # @param block [Proc] scenario to execute
    def initialize(name, &block)
      @name   = name
      @block  = block
    end
  end
end
