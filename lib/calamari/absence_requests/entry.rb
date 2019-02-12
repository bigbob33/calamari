module Calamari
  module AbsenceRequests
    class Entry
      STATUS_ACCEPTED = 'ACCEPTED'.freeze
      STATUS_PENDING = 'PENDING'.freeze

      attr_reader :id, :from, :to, :absence_type_name, :absence_type_id, :absence_category,
                  :status, :entitlement_amount, :amount_first_day, :amount_last_day, :created,
                  :updated

      def initialize(raw_entry)
        @id = raw_entry['id']
        @from = to_date_time(raw_entry['from'])
        @to = to_date_time(raw_entry['to'])
        @absence_type_name = raw_entry['absenceTypeName']
        @absence_type_id = raw_entry['absenceTypeId']
        @absence_category = raw_entry['absenceCategory']
        @status = raw_entry['status']
        @entitlement_amount = raw_entry['entitlementAmount']
        @amount_first_day = raw_entry['amountFirstDay']
        @amount_last_day = raw_entry['amountLastDay']
        @created = raw_entry['created']
        @updated = raw_entry['updated']
      end

      def accepted?
        status == STATUS_ACCEPTED
      end

      def pending?
        status == STATUS_PENDING
      end

      private

      def to_date_time(date_string)
        Time.parse(date_string)
      end
    end
  end
end
