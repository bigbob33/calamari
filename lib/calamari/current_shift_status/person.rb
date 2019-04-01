module Calamari
  module CurrentShiftStatus
    class Person
      attr_reader :first_name, :last_name, :email, :external_id

      def initialize(raw_person)
        @first_name = raw_person[:firstName]
        @last_name = raw_person[:lastName]
        @email = raw_person[:email]
        @external_id = raw_person[:externalId]
      end
    end
  end
end