# frozen_string_literal: true

require_relative 'scenario'
require 'active_support/callbacks'

module Plantae
  # Extend this class to create your own seeders
  class Seeder
    include ActiveSupport::Callbacks
    define_callbacks :create, :destroy
    delegate :scenarios, to: :class

    class << self
      attr_reader :scenarios

      # Create scenarios in your seeder using the following format:
      #
      #   scenario "this is my scenario" do
      #     ...
      #   end
      def scenario(name, &block)
        @scenarios ||= []
        @scenarios << Scenario.new(name, &block)
      end

      # Define code to execute on create, this is used to create
      # preconditions before running any scenarios.
      def create(*args, &block)
        set_callback(:create, :before, *args, &block)
      end

      # Define code to execute on destroy, this is used to clean up
      # the items created through the seeder.
      def destroy(*args, &block)
        set_callback(:destroy, :before, *args, &block)
      end
    end

    # Runs all create blocks
    def create
      run_callbacks :create
    end

    # Runs all destroy blocks
    def destroy
      run_callbacks :destroy
    end

    # Run scenario(s)
    #
    # @param name [String, nil] when given only run the scenario matching the given name and skip the create logic
    def run(name = nil)
      create unless name.present?

      scenarios.select { |scenario| name.blank? || scenario.name == name }
               .each do |scenario|
        instance_exec(&scenario.block)
      end
    end
  end
end
