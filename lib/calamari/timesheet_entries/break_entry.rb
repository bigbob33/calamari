module Calamari
  module TimesheetEntries
    class BreakEntry
      attr_reader :from, :to, :duration, :break_type

      def initialize(raw_break_entry)
        @from = to_date_time(raw_break_entry['from'])
        @to = to_date_time(raw_break_entry['to'])
        @duration = raw_break_entry['duration'].to_i
        @break_type = BreakType.new(raw_break_entry['breakType'])
      end

      class BreakType
        attr_reader :id, :name

        def initialize(raw_break)
          @id = raw_break['id']
          @name = raw_break['name']
        end
      end

      private

      def to_date_time(date_string)
        date_string.nil? ? date_string : Time.parse(date_string)
      end
    end
  end
end