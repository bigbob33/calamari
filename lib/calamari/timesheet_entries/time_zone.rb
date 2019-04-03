module Calamari
  module TimesheetEntries
    class TimeZone
      attr_reader :display_name, :id, :raw_offset, :dstsavings

      def initialize(raw_time_zone)
        @display_name = raw_time_zone['displayName']
        @id = raw_time_zone['id']
        @raw_offset = raw_time_zone['raw_offset']
        @dstsavings = raw_time_zone['dstsavings']
      end
    end
  end
end