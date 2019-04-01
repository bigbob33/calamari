require_relative 'person'

module Calamari
  module CurrentShiftStatus
    class Entry
      attr_reader :person, :status

      def initialize(raw_entry)
        @person = build_person(raw_entry[:person])
        @status = raw_entry[:status]
      end

      private

      def build_person(raw_person)
        CurrentShiftStatus::Person.new(raw_person)
      end
    end
  end
end